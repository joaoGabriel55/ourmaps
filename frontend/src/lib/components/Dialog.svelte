<script lang="ts">
  import { twMerge } from "tailwind-merge";

  type Props = {
    id: string;
    open?: boolean;
    title: string;
    description?: string;
    submitLabel?: string;
    danger?: boolean;
    onConfirm: () => void;
    onCancel?: () => void;
    children?: any;
  };

  let {
    id,
    open,
    title,
    description,
    submitLabel,
    danger,
    onConfirm,
    onCancel,
    children,
  }: Props = $props();
</script>

<dialog
  {id}
  {...open && { open }}
  class="modal modal-bottom sm:modal-middle"
>
  <div class="modal-box">
    <h3 class="text-lg font-bold">{title}</h3>
    {#if children}
      <div class="py-4">
        {@render children()}
      </div>
    {:else}
      <p class="py-4">
        {description}
      </p>
    {/if}
    <div class="modal-action">
      <form class="flex gap-2" method="dialog">
        <button class="btn" onclick={onCancel}>Cancel</button>
        <button
          class={twMerge("btn btn-primary", danger && "btn-error")}
          onclick={onConfirm}
          >{submitLabel || "Confirm"}
        </button>
      </form>
    </div>
  </div>
</dialog>
