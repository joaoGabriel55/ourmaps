import type { HTTPClient } from "../http-client";

export const addCustomMapCollaborators = async (
  mapId: string,
  collaborators: Array<string>,
  httpClient: HTTPClient
) => {
  return await httpClient.patch(`/custom_maps/${mapId}/collaborators`, {
    collaborators,
  });
};
