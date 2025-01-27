import type { CustomMap, CustomMapVisibility } from "$core/custom-map";
import { type HTTPClient } from "$lib/api/http-client";
import { toCustomMap } from "./parser";

export const getAllCustomMaps = async (
  ownerId: string,
  visibility: CustomMapVisibility,
  httpClient: HTTPClient
): Promise<CustomMap[]> => {
  try {
    const searchParams = new URLSearchParams();

    searchParams.set("owner_id", ownerId);
    searchParams.set("visibility", visibility);

    const { data } = await httpClient.get("/custom_maps", {
      owner_id: ownerId,
      visibility,
    });

    return data?.map(toCustomMap);
  } catch (error: any) {
    throw error;
  }
};
