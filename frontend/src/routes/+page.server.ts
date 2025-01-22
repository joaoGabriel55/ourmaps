import { getPrivateMaps, getPublicMaps } from "$lib/api";

export const load = async ({ url }) => {
  console.log(url.pathname)
  return {
    userMaps: await getPrivateMaps(),
    sharedMaps: await getPublicMaps(),
  };
};
