import { getUserIdByToken } from "$lib";
import { getAllCustomMaps } from "$lib/api/custom-maps/get-all.js";
import { makeOurMapsAPI } from "$lib/api/http-client";
import { redirect } from "@sveltejs/kit";

export const load = async ({ cookies }) => {
  const token = cookies.get("auth_token");

  if (!token) throw redirect(303, "/login");

  const ourMapsAPI = makeOurMapsAPI(token);

  const userId = getUserIdByToken(token);

  const maps = await getAllCustomMaps(userId, ourMapsAPI);

  return {
    userMaps: maps.filter((map) => map.visibility === "private"),
    sharedMaps: maps.filter((map) => map.visibility === "public"),
  };
};
