import { getAllCustomMaps } from "$lib/api/custom-maps/get-all.js";
import { userStore } from "$lib/stores/user.js";
import { redirect } from "@sveltejs/kit";
import { get } from "svelte/store";

export const load = async ({ cookies }) => {
  const token = cookies.get("auth_token") || "";
  const user = get(userStore);

  if (!token || !user) {
    throw redirect(303, "/login");
  }

  const maps = await getAllCustomMaps(user.id);

  return {
    userMaps: maps.filter((map) => map.visibility === "private"),
    sharedMaps: maps.filter((map) => map.visibility === "public"),
  };
};
