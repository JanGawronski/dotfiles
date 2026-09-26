#ifndef DWL_BEHAVIOR_H
#define DWL_BEHAVIOR_H

#include <stdint.h>

static void
centerinitialfloating(struct wlr_box *geometry, const struct wlr_box *area)
{
	if (geometry->width <= 0 || geometry->height <= 0 ||
			geometry->width >= area->width || geometry->height >= area->height)
		return;

	if ((geometry->x != area->x || geometry->y != area->y) &&
			geometry->x >= area->x && geometry->y >= area->y &&
			(int64_t)geometry->x + geometry->width <= (int64_t)area->x + area->width &&
			(int64_t)geometry->y + geometry->height <= (int64_t)area->y + area->height)
		return;

	geometry->x = area->x + (area->width - geometry->width) / 2;
	geometry->y = area->y + (area->height - geometry->height) / 2;
}

static void
swaplinks(struct wl_list *first, struct wl_list *second)
{
	struct wl_list *firstprev, *secondprev;

	if (first == second)
		return;

	firstprev = first->prev;
	secondprev = second->prev;
	if (first->next == second) {
		wl_list_remove(second);
		wl_list_insert(firstprev, second);
	} else if (second->next == first) {
		wl_list_remove(first);
		wl_list_insert(secondprev, first);
	} else {
		wl_list_remove(first);
		wl_list_remove(second);
		wl_list_insert(firstprev, second);
		wl_list_insert(secondprev, first);
	}
}

#endif
