import { findCustomMap } from "$lib/api/custom-maps/find";
import { error } from "@sveltejs/kit";

export const load = async ({ params }: { params: { id: string } }) => {
  const map = await findCustomMap(params.id);

  if (map) return map;

  error(404, "Not found");
};

export const ssr = false;
