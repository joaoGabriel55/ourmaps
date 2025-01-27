import { getUserIdByToken } from "$lib/jwt";
import { findCustomMap } from "$lib/api/custom-maps/find";
import { makeOurMapsAPI } from "$lib/api/http-client";
import { redirect } from "@sveltejs/kit";

export const load = async ({ cookies, params }) => {
  const token = cookies.get("auth_token") || "";
  const userId = getUserIdByToken(token);

  if (!token) {
    throw redirect(303, "/login");
  }

  const map = await findCustomMap(params.id, makeOurMapsAPI(token));

  return { map, token, userId };
};
