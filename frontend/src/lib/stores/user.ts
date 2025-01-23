import type { User } from "$core/user";
import { writable } from "svelte/store";

export const userStore = writable<User | null>(null);
