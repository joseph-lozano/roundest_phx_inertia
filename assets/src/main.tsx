import { createInertiaApp } from "@inertiajs/react";
import axios from "axios";
import { hydrateRoot } from "react-dom/client";
import Layout from "./components/Layout";
import "./main.css";

axios.defaults.xsrfHeaderName = "x-csrf-token";

type Page = {
  default: {
    layout: (page: any) => any;
  };
};

createInertiaApp({
  resolve: (name) => {
    const pages = import.meta.glob("./pages/**/*.tsx", { eager: true });
    const page = pages[`./pages/${name}.tsx`] as Page;
    page.default.layout =
      page.default.layout || ((page) => <Layout children={page} />);
    return page;
  },
  setup({ el, App, props }) {
    hydrateRoot(el, <App {...props} />);
  },
});
