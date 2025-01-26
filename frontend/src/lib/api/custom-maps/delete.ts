import type { HTTPClient } from "../http-client";

export const deleteCustomMap = async (id: string, httpClient: HTTPClient) => {
  return await httpClient.delete(`/custom_maps/${id}`);
};
