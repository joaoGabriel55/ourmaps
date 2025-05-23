import { getUserIdByToken } from "$lib/jwt";
import { getAllCustomMaps } from "$lib/api/custom-maps/get-all.js";
import { makeOurMapsAPI } from "$lib/api/http-client";
import { redirect } from "@sveltejs/kit";
import { findUserById } from "$lib/api/users/find-by-id";

const getVisibility = (visibility: string | null) => {
  switch (visibility) {
    case "private":
      return "private";
    case "public":
      return "public";
    default:
      return "private";
  }
};

export const load = async ({ cookies, url }) => {
  const token = cookies.get("auth_token");

  if (!token) throw redirect(303, "/login");

  const ourMapsAPI = makeOurMapsAPI(token);

  const userId = getUserIdByToken(token);

  const visibility = getVisibility(url.searchParams.get("visibility"));

  const userProfile = await findUserById(userId, ourMapsAPI);

  if (!userProfile) {
    throw redirect(303, "/login");
  }

  const customMaps = await getAllCustomMaps(userId, { visibility }, ourMapsAPI);

  return {
    token,
    userProfile,
    customMaps,
  };
};
