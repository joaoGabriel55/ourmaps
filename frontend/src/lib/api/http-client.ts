import axios from "axios";

import { env } from "$env/dynamic/public";

const makeHttpClient = (baseUrl: string, token?: string) => {
  const axiosInstance = axios.create({
    baseURL: baseUrl,
    headers: {
      Authorization: `Bearer ${token}`,
    },
  });

  return {
    get: async <T = any>(url: string) => {
      const response = await axiosInstance.get<T>(url);

      return { data: response.data, status: response.status };
    },
    post: async <T = any>(url: string, data: any) => {
      const response = await axiosInstance.post<T>(url, data);

      return { data: response.data, status: response.status };
    },
    put: async <T = any>(url: string, data: any) => {
      const response = await axiosInstance.put<T>(url, data);

      return { data: response.data, status: response.status };
    },
    delete: async <T = any>(url: string) => {
      const response = await axiosInstance.delete<T>(url);

      return { data: response.data, status: response.status };
    },
  };
};

export type HTTPClient = ReturnType<typeof makeHttpClient>;

export const makeOurMapsAPI = (token?: string) => makeHttpClient(env.PUBLIC_API_URL, token);
