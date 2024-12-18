import { getPrivateMaps } from "$lib/api";
import { error } from "@sveltejs/kit";

export const load = async ({ params }: { params: { id: string } }) => {
  const map = (await getPrivateMaps()).find(
    (map) => map.id === Number(params.id)
  );

  if (map) return map;

  error(404, "Not found");
};

export const ssr = false;
