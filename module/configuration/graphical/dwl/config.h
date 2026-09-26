#define COLOR(hex) { ((hex >> 24) & 0xFF) / 255.0f, \
	((hex >> 16) & 0xFF) / 255.0f, ((hex >> 8) & 0xFF) / 255.0f, \
	(hex & 0xFF) / 255.0f }

static const int sloppyfocus = 1;
static const int bypass_surface_visibility = 0;
static const unsigned int borderpx = 0;
static const unsigned int snap = 32;
static const float rootcolor[] = COLOR(0x000000ff);
static const float bordercolor[] = COLOR(0x444444ff);
static const float focuscolor[] = COLOR(0x005577ff);
static const float urgentcolor[] = COLOR(0xff0000ff);
static const float fullscreen_bg[] = { 0.0f, 0.0f, 0.0f, 1.0f };

#define TAGCOUNT 9
static int log_level = WLR_ERROR;

static const Rule rules[] = {
	{ "Gimp_EXAMPLE", NULL, 0, 1, -1 },
};

static const Layout layouts[] = {
	{ "[]=", tile },
	{ "[M]", monocle },
};

static const MonitorRule monrules[] = {
#ifdef DWL_COMPUTER_MONITORS
	{ "DP-1", 0.5f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, 0, 0, 1u << 0 },
	{ "HDMI-A-1", 0.5f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, 1920, 0, 1u << 1 },
#endif
	{ NULL, 0.5f, 1, 1, &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1, 0 },
};

#ifdef DWL_COMPUTER_MONITORS
static const char *initial_cursor_output = "DP-1";
#else
static const char *initial_cursor_output = NULL;
#endif

static const struct xkb_rule_names xkb_rules = {
	.layout = "pl",
};

static const int repeat_rate = 25;
static const int repeat_delay = 600;
static const int chord_timeout_ms = 2000;
static const int cursor_timeout = 1;

static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 0;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.0;
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

#define MODKEY WLR_MODIFIER_LOGO
#define TAGKEYS(KEY,TAG) \
	{ MODKEY, KEY, view, {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, KEY, tag, {.ui = 1 << TAG} }

#define SHCMD(CMD) { .v = (const char *[]) { "/bin/sh", "-c", CMD, NULL } }
#define CHORD1(M, A, FN, ARG) { M, { A }, 1, FN, ARG }
#define CHORD2(M, A, B, FN, ARG) { M, { A, B }, 2, FN, ARG }
#define CHORD3(M, A, B, C, FN, ARG) { M, { A, B, C }, 3, FN, ARG }
#define CHORD4(M, A, B, C, D, FN, ARG) { M, { A, B, C, D }, 4, FN, ARG }
#define SINK_VOLUME(KEY, VALUE) \
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_v, KEY, spawn, \
		SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ " VALUE))
#define PLAYER_VOLUME(KEY, VALUE) \
	CHORD4(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_v, KEY, spawn, \
		SHCMD("playerctl volume " VALUE))

static const char *termcmd[] = { "alacritty", NULL };
static const char *menucmd[] = { "fuzzel", NULL };

static const Key keys[] = {
	{ MODKEY, XKB_KEY_p, spawn, {.v = menucmd} },
	{ MODKEY, XKB_KEY_grave, spawn, {.v = termcmd} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Return, spawn, {.v = termcmd} },
	{ MODKEY, XKB_KEY_e, spawn, SHCMD("emacs") },
	{ MODKEY, XKB_KEY_b, spawn, SHCMD("systemctl --user kill --signal=SIGUSR1 waybar.service") },
	{ MODKEY, XKB_KEY_w, focusmon, {.i = WLR_DIRECTION_RIGHT} },
	{ MODKEY, XKB_KEY_x, spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") },
	{ MODKEY, XKB_KEY_v, spawn, SHCMD("dwl-clipboard-history") },
	{ 0, XKB_KEY_Print, spawn, SHCMD("dwl-screenshot region") },
	{ MODKEY, XKB_KEY_Print, spawn, SHCMD("dwl-screenshot screen") },
	{ MODKEY|WLR_MODIFIER_ALT, XKB_KEY_Print, spawn, SHCMD("dwl-screenshot file") },
	{ 0, XKB_KEY_XF86AudioPlay, spawn, SHCMD("playerctl play-pause") },
	{ 0, XKB_KEY_XF86AudioPause, spawn, SHCMD("playerctl play-pause") },
	{ 0, XKB_KEY_XF86AudioPrev, spawn, SHCMD("playerctl position 30-") },

	{ MODKEY, XKB_KEY_j, focusstack, {.i = +1} },
	{ MODKEY, XKB_KEY_k, focusstack, {.i = -1} },
	{ MODKEY, XKB_KEY_Tab, focusstack, {.i = +1} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Tab, focusstack, {.i = -1} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_j, swapstack, {.i = +1} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_k, swapstack, {.i = -1} },
	{ MODKEY, XKB_KEY_m, focusmaster, {0} },
	{ MODKEY, XKB_KEY_i, incnmaster, {.i = +1} },
	{ MODKEY, XKB_KEY_d, incnmaster, {.i = -1} },
	{ MODKEY, XKB_KEY_comma, incnmaster, {.i = +1} },
	{ MODKEY, XKB_KEY_period, incnmaster, {.i = -1} },
	{ MODKEY, XKB_KEY_h, setmfact, {.f = -0.03f} },
	{ MODKEY, XKB_KEY_l, setmfact, {.f = +0.03f} },
	{ MODKEY, XKB_KEY_Return, swapmaster, {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_c, killclient, {0} },
	{ MODKEY, XKB_KEY_t, sink, {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_m, setlayout, {.v = &layouts[1]} },
	{ MODKEY, XKB_KEY_space, setlayout, {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_space, setlayout, {.v = &layouts[0]} },
	{ MODKEY, XKB_KEY_f, togglefloating, {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_f, togglefullscreen, {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_comma, tagmon, {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_period, tagmon, {.i = WLR_DIRECTION_RIGHT} },
	TAGKEYS(XKB_KEY_1, 0),
	TAGKEYS(XKB_KEY_2, 1),
	TAGKEYS(XKB_KEY_3, 2),
	TAGKEYS(XKB_KEY_4, 3),
	TAGKEYS(XKB_KEY_5, 4),
	TAGKEYS(XKB_KEY_6, 5),
	TAGKEYS(XKB_KEY_7, 6),
	TAGKEYS(XKB_KEY_8, 7),
	TAGKEYS(XKB_KEY_9, 8),
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_q, quit, {0} },
	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT, XKB_KEY_BackSpace, quit, {0} },
#define CHVT(N) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT, XKB_KEY_F##N, chvt, {.ui = N} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

static const Chord chords[] = {
	CHORD1(MODKEY, XKB_KEY_z, spawn, SHCMD("sleep 0.25 && wlopm --off '*'")),
	CHORD2(MODKEY, XKB_KEY_Alt_L, XKB_KEY_Print, spawn, SHCMD("dwl-screenshot file")),
	CHORD2(MODKEY|WLR_MODIFIER_ALT, XKB_KEY_Alt_L, XKB_KEY_Print, spawn, SHCMD("dwl-screenshot file")),
	CHORD2(MODKEY, XKB_KEY_n, XKB_KEY_a, spawn, SHCMD("dunstctl action")),
	CHORD2(MODKEY, XKB_KEY_n, XKB_KEY_c, spawn, SHCMD("dunstctl close")),

	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_m, XKB_KEY_m, spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_m, XKB_KEY_t, spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_m, XKB_KEY_s, spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_m, XKB_KEY_e, spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_m, XKB_KEY_d, spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_b, XKB_KEY_e, spawn, SHCMD("bluetoothctl power on")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_b, XKB_KEY_d, spawn, SHCMD("bluetoothctl power off")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_w, XKB_KEY_e, spawn, SHCMD("nmcli radio wifi on")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_w, XKB_KEY_d, spawn, SHCMD("nmcli radio wifi off")),
	SINK_VOLUME(XKB_KEY_grave, "0"),
	SINK_VOLUME(XKB_KEY_1, "0.1"),
	SINK_VOLUME(XKB_KEY_2, "0.2"),
	SINK_VOLUME(XKB_KEY_3, "0.3"),
	SINK_VOLUME(XKB_KEY_4, "0.4"),
	SINK_VOLUME(XKB_KEY_5, "0.5"),
	SINK_VOLUME(XKB_KEY_6, "0.6"),
	SINK_VOLUME(XKB_KEY_7, "0.7"),
	SINK_VOLUME(XKB_KEY_8, "0.8"),
	SINK_VOLUME(XKB_KEY_9, "0.9"),
	SINK_VOLUME(XKB_KEY_0, "1"),

	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_p, spawn, SHCMD("playerctl play-pause")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_e, spawn, SHCMD("playerctl play")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_d, spawn, SHCMD("playerctl pause")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_k, spawn, SHCMD("playerctl stop")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_f, spawn, SHCMD("playerctl position 30+")),
	CHORD3(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_b, spawn, SHCMD("playerctl position 30-")),
	PLAYER_VOLUME(XKB_KEY_grave, "0"),
	PLAYER_VOLUME(XKB_KEY_1, "0.1"),
	PLAYER_VOLUME(XKB_KEY_2, "0.2"),
	PLAYER_VOLUME(XKB_KEY_3, "0.3"),
	PLAYER_VOLUME(XKB_KEY_4, "0.4"),
	PLAYER_VOLUME(XKB_KEY_5, "0.5"),
	PLAYER_VOLUME(XKB_KEY_6, "0.6"),
	PLAYER_VOLUME(XKB_KEY_7, "0.7"),
	PLAYER_VOLUME(XKB_KEY_8, "0.8"),
	PLAYER_VOLUME(XKB_KEY_9, "0.9"),
	PLAYER_VOLUME(XKB_KEY_0, "1"),
	CHORD4(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_l, XKB_KEY_d, spawn, SHCMD("playerctl loop None")),
	CHORD4(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_l, XKB_KEY_e, spawn, SHCMD("playerctl loop Track")),
	CHORD4(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_s, XKB_KEY_s, spawn, SHCMD("playerctl shuffle Toggle")),
	CHORD4(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_s, XKB_KEY_t, spawn, SHCMD("playerctl shuffle Toggle")),
	CHORD4(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_s, XKB_KEY_e, spawn, SHCMD("playerctl shuffle On")),
	CHORD4(MODKEY, XKB_KEY_s, XKB_KEY_p, XKB_KEY_s, XKB_KEY_d, spawn, SHCMD("playerctl shuffle Off")),
};

static const Button buttons[] = {
	{ MODKEY, BTN_LEFT, moveresize, {.ui = CurMove} },
	{ MODKEY, BTN_MIDDLE, swapmaster, {0} },
	{ MODKEY, BTN_RIGHT, moveresize, {.ui = CurResize} },
};

static const Axis axes[] = {
	{ 0, 0, NULL, {0} },
};
