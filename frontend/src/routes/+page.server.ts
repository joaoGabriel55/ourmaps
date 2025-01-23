import { getAllCustomMaps } from "$lib/api/custom-maps/get-all.js";

export const load = async ({ url }) => {
  const maps = await getAllCustomMaps("61682ddc-08da-4eef-921c-65db6143ff36");

  return {
    userMaps: maps.filter((map) => map.visibility === "private"),
    sharedMaps: maps.filter((map) => map.visibility === "public"),
  };
};
