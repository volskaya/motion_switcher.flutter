package dev.volskaya.motion_switcher_example

import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.content.res.Configuration
import android.content.res.Resources
import android.hardware.SensorManager
import android.os.Build
import android.os.Bundle
import android.util.DisplayMetrics
import android.view.*
import android.widget.FrameLayout
import android.widget.ImageView
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterSurfaceView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


abstract class WrappedFlutterActivity : FlutterActivity() {
    companion object {
        const val fitSystemInsets = true
    }

    var preferredRefreshRate: Float? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        increaseRefreshRatePreference()
        super.onCreate(savedInstanceState)
        setLayoutParams()
    }

    override fun onFlutterSurfaceViewCreated(flutterSurfaceView: FlutterSurfaceView) {
        super.onFlutterSurfaceViewCreated(flutterSurfaceView)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            flutterSurfaceView.holder.addCallback(object : SurfaceHolder.Callback {
                @SuppressLint("WrongConstant")
                override fun surfaceCreated(holder: SurfaceHolder) {
                    holder.surface.setFrameRate(preferredRefreshRate ?: 120f, Surface.FRAME_RATE_COMPATIBILITY_FIXED_SOURCE)
                }

                @SuppressLint("WrongConstant")
                override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
                    holder.surface.setFrameRate(preferredRefreshRate ?: 120f, Surface.FRAME_RATE_COMPATIBILITY_FIXED_SOURCE)
                }

                override fun surfaceDestroyed(holder: SurfaceHolder) {}
            })
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "dev.volskaya.app").setMethodCallHandler { call, result ->
            when (call.method) {
                "getGravityEarth" -> result.success(SensorManager.GRAVITY_EARTH)
                "getScrollFriction" -> result.success(ViewConfiguration.getScrollFriction())
                "getTouchSlop" -> result.success(ViewConfiguration.get(context).scaledTouchSlop)
                "showToast" -> {
                    val text = call.argument<String>("text") ?: ""
                    val long = call.argument<Boolean>("long") ?: false
                    val length = if (long)  { Toast.LENGTH_LONG } else { Toast.LENGTH_SHORT }

                    Toast.makeText(context, text, length).show()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getNavigationBarHeight(): Int {
        val resources: Resources = context.resources
        val resourceId: Int = resources.getIdentifier("navigation_bar_height", "dimen", "android")
        return if (resourceId > 0) { resources.getDimensionPixelSize(resourceId) } else 0
    }

    // NOTE: Match behavior with the same code from flutter engine's FlutterView.
    private enum class ZeroSides {
        NONE, LEFT, RIGHT, BOTH
    }

    private fun calculateShouldZeroSides(): ZeroSides {
        // We get both orientation and rotation because rotation is all 4
        // rotations relative to default rotation while orientation is portrait
        // or landscape. By combining both, we can obtain a more precise measure
        // of the rotation.
        try {
            val orientation = context.resources.configuration.orientation
            val rotation = (context.getSystemService(Context.WINDOW_SERVICE) as WindowManager)
                    .defaultDisplay
                    .rotation
            if (orientation == Configuration.ORIENTATION_LANDSCAPE) {
                if (rotation == Surface.ROTATION_90) {
                    return ZeroSides.RIGHT
                } else if (rotation == Surface.ROTATION_270) {
                    // In android API >= 23, the nav bar always appears on the "bottom" (USB) side.
                    return if (Build.VERSION.SDK_INT >= 23) ZeroSides.LEFT else ZeroSides.RIGHT
                } else if (rotation == Surface.ROTATION_0 || rotation == Surface.ROTATION_180) {
                    return ZeroSides.BOTH
                }
            }
        } catch (_: NoSuchMethodError) {}

        // Square orientation deprecated in API 16, we will not check for it and return false
        // to be safe and not remove any unique padding for the devices that do use it.
        return ZeroSides.NONE
    }

    // Apply root insets to the FrameView where the FlutterView will build. These insets
    // are added to the ones passed to Flutter media queries.
    //
    // Below Lollipop the navigation bar height is retrieved from a resource and applied
    // based on screen orientation.
    private fun setLayoutParams() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val metrics = DisplayMetrics()
            val contentView = window.findViewById<FrameLayout>(android.R.id.content)

            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
            window.windowManager.defaultDisplay.getMetrics(metrics)
            window.decorView.fitsSystemWindows = fitSystemInsets
            window.decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
            window.navigationBarColor = 0x00000000
            window.statusBarColor = 0x01000000
            contentView.fitsSystemWindows = fitSystemInsets

            (contentView as View).setOnApplyWindowInsetsListener { _, insets ->
                if (Build.VERSION.SDK_INT >= 23) {
                    return@setOnApplyWindowInsetsListener window.decorView.rootWindowInsets
                }

                when (calculateShouldZeroSides()) {
                    ZeroSides.RIGHT -> insets.replaceSystemWindowInsets(
                            insets.systemWindowInsetLeft,
                            insets.systemWindowInsetTop,
                            insets.systemWindowInsetRight + getNavigationBarHeight(),
                            insets.systemWindowInsetBottom)
                    ZeroSides.LEFT -> insets.replaceSystemWindowInsets(
                            insets.systemWindowInsetLeft + getNavigationBarHeight(),
                            insets.systemWindowInsetTop,
                            insets.systemWindowInsetRight,
                            insets.systemWindowInsetBottom)
                    ZeroSides.BOTH,
                    ZeroSides.NONE -> insets.replaceSystemWindowInsets(
                            insets.systemWindowInsetLeft,
                            insets.systemWindowInsetTop,
                            insets.systemWindowInsetRight,
                            insets.systemWindowInsetBottom + getNavigationBarHeight())
                }
            }

            // I assume flutter still uses some old default of LinearLayout -> LayoutStub, FrameLayout,
            // or something, breaking `fitsSystemWindows`.
            (contentView.parent as ViewGroup).removeView(contentView)
            (window.decorView as ViewGroup).removeAllViews()
            (window.decorView as ViewGroup).addOnLayoutChangeListener { view, _, _, _, _, _, _, _, _ ->
                when (view.id) {
                    else -> {
                        try {
                            window.findViewById<View>(android.R.id.navigationBarBackground).also { (it.parent as ViewGroup).removeView(it) }
                        } catch (_: IllegalStateException) {
                        } catch (_: NullPointerException) {
                        }

                        try {
                            window.findViewById<View>(android.R.id.statusBarBackground).also { (it.parent as ViewGroup).removeView(it) }
                        } catch (_: IllegalStateException) {
                        } catch (_: NullPointerException) {
                        }
                    }
                }
            }
            (window.decorView as ViewGroup).addView(contentView)
        }
    }

    // Defaults to the fastest available refresh rate the device allows.
    //
    // Since Flutter is drawn in a SurfaceView, android assumes this is some kind of
    // a video and dynamically lowers refresh rates to 60.
    //
    // This won't override user's manual refresh rate setting - if they're set their screen
    // to 60hz, then flutter will draw at 60hz as well, until that setting is changed.
    private fun increaseRefreshRatePreference() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) return // Android version too low.

        try {
            (activity.getSystemService(Context.WINDOW_SERVICE) as WindowManager?)?.defaultDisplay?.let {
                display ->
                    var preferredMode: Display.Mode = display.mode

                    // Finds a mode with a higher refresh rate than the `preferredMode`.
                    display.supportedModes?.forEach {
                        if (it.physicalHeight == preferredMode.physicalHeight &&
                                it.physicalWidth == preferredMode.physicalWidth &&
                                it.refreshRate > preferredMode.refreshRate) {
                            preferredMode = it
                        }
                    }

                    activity.window?.attributes?.let {
                        preferredRefreshRate = preferredMode.refreshRate
                        it.preferredDisplayModeId = preferredMode.modeId
                        activity.window?.attributes = it
                    }
            }
        } catch (e: NoSuchMethodError) {}
    }
}
