import { useState } from "react";

import { Home, LucideDog, Bell, Menu, Plus } from "lucide-react";
import axios from "axios";

//linkbackend
const BASE_URL_PRODUCT = "http://localhost:5000/api/products";

function Product({ handleSubmit, formProduct, handleChange, setFormProduct }) {
  return (
    <div className="bg-white-800 p-4 rounded-xl">
      <h2 className="text-xl font-semibold mb-4 text-center">
        Tambah Produk Baru
      </h2>
      <form onSubmit={handleSubmit} className="space-y-3">
        <input
          name="name"
          value={formProduct.name}
          onChange={handleChange}
          placeholder="Nama Product"
          className="w-full border p-2 rounded"
        />
        <input
          name="slug"
          value={formProduct.slug}
          onChange={handleChange}
          placeholder="slug"
          className="w-full border p-2 rounded"
        />
        <textarea
          name="description"
          value={formProduct.description}
          onChange={handleChange}
          placeholder="Deskripsi Produk"
          className="w-full border p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
          rows={3}
        />
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <input
            name="price"
            type="number"
            value={formProduct.price}
            onChange={handleChange}
            placeholder="Harga Produk (Rp)"
            className="w-full border p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
          />
          <input
            name="comparePrice"
            type="number"
            value={formProduct.comparePrice}
            onChange={handleChange}
            placeholder="Harga Pembanding (Rp)"
            className="w-full border p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
          />
        </div>
        <select
          name="category"
          value={formProduct.category}
          onChange={handleChange}
          className="w-full border p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
        >
          <option value="">Pilih Kategori</option>
          <option value="makanan">Makanan</option>
          <option value="mainan">Mainan</option>
          <option value="aksesoris">Aksesoris</option>
          <option value="perawatan">Perawatan</option>
        </select>
        <select
          name="petType"
          value={formProduct.petType}
          onChange={handleChange}
          className="w-full border p-2 rounded"
        >
          <option value="">pilihan pet</option>
          <option value="kucing">Kucing</option>
          <option value="anjing">Anjing</option>
          <option value="burung">burung</option>
        </select>
        <input
          name="brand"
          value={formProduct.brand}
          onChange={handleChange}
          placeholder="brand"
          className="w-full border p-2 rounded"
        />
        <input
          name="weight"
          type="number"
          value={formProduct.weight}
          onChange={handleChange}
          placeholder="weight"
          className="w-full border p-2 rounded"
        />
        <select
          name="unit"
          value={formProduct.unit}
          onChange={handleChange}
          className="w-full border p-2 rounded"
        >
          <option value="">pilihan unit</option>
          <option value="gr">gr</option>
          <option value="kg">kg</option>
          <option value="ml">ml</option>
          <option value="l">l</option>
          <option value="pcs">pcs</option>
        </select>
        <input
          name="stock"
          type="number"
          value={formProduct.stock}
          onChange={handleChange}
          placeholder="stock"
          className="w-full border p-2 rounded"
        />
        <div className="w-full border p-2 rounded">
          <label className="block mb-2 text-sm font-medium">
            Upload Gambar
          </label>
          <input
            name="images"
            type="file"
            multiple
            accept="image/*"
            onChange={handleChange}
            className="w-full border p-2 rounded"
          />
          {formProduct.images.length > 0 && (
            <div className="grid grid-cols-3 md:grid-cols-4 gap-3 mt-3">
              {formProduct.images.map((file, index) => {
                const previewUrl = URL.createObjectURL(file);
                return (
                  <div
                    key={index}
                    className="relative border rounded-lg overflow-hidden shadow-sm"
                  >
                    <img
                      src={previewUrl}
                      alt={`preview-${index}`}
                      className="w-full h-24 object-cover"
                    />
                    <button
                      type="button"
                      onClick={() => {
                        setFormProduct((prev) => ({
                          ...prev,
                          images: prev.images.filter((_, i) => i !== index),
                        }));
                      }}
                      className="absolute top-1 right-1 bg-red-500 text-white text-xs rounded-full px-2 py-0.5"
                    >
                      ✕
                    </button>
                  </div>
                );
              })}
            </div>
          )}
        </div>

        <input
          name="tags"
          value={formProduct.tags}
          onChange={handleChange}
          placeholder="tags"
          className="w-full border p-2 rounded"
        />
        <input
          name="rating"
          type="number"
          value={formProduct.rating}
          onChange={handleChange}
          max={5}
          className="w-full border p-2 rounded"
        />
        <input
          name="reviewCount"
          value={formProduct.reviewCount}
          onChange={handleChange}
          type="number"
          placeholder="reviewCount"
          className="w-full border p-2 rounded"
        />
        <button
          onClick={handleSubmit}
          className="w-full bg-white text-amber-800 font-bold py-3 px-6 rounded-lg hover:bg-amber-100 transition-colors flex items-center justify-center gap-2"
        >
          <Plus className="h-5 w-5" />
          Tambah Produk
        </button>
      </form>
    </div>
  );
}

function Dashboard() {
  return (
    <div className="p-4">
      <p>Ini bagian Dashboard</p>
    </div>
  );
}

export default function AdminPetshop() {
  const [activeTab, setActiveTab] = useState("dashboard");
  const [loading] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [formProduct, setFormProduct] = useState({
    name: "",
    slug: "",
    description: "",
    price: "",
    comparePrice: "",
    category: "",
    petType: "",
    brand: "",
    weight: "",
    unit: "",
    stock: "",
    images: [],
    tags: [],
    rating: "",
    reviewCount: "",
    isAvailable: true,
  });

  const handleChange = (e) => {
    const { name, value, files, type } = e.target;

    if (name === "images") {
      const newFiles = Array.from(files);
      setFormProduct((prev) => ({
        ...prev,
        images: [...prev.images, ...newFiles],
      }));
    } else if (name === "tags") {
      setFormProduct((prev) => ({
        ...prev,
        tags: value.split(",").map((tag) => tag.trim()),
      }));
    } else if (type === "checkbox") {
      setFormProduct((prev) => ({
        ...prev,
        [name]: e.target.checked,
      }));
    } else {
      setFormProduct((prev) => ({
        ...prev,
        [name]: value,
      }));
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const formData = new FormData();

      for (const key in formProduct) {
        if (key === "images") continue;
        if (key === "tags") {
          formData.append("tags", JSON.stringify(formProduct.tags));
        } else {
          formData.append(key, formProduct[key]);
        }
      }

      formProduct.images.forEach((file) => {
        formData.append("images", file);
      });

      const response = await axios.post(BASE_URL_PRODUCT, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      alert("✅ Produk berhasil ditambahkan!");
      console.log("Response:", response.data);

      // Reset form
      setFormProduct({
        name: "",
        slug: "",
        description: "",
        price: "",
        comparePrice: "",
        category: "",
        petType: "",
        brand: "",
        weight: "",
        unit: "",
        stock: "",
        images: [],
        tags: [],
        rating: "",
        reviewCount: "",
        isAvailable: true,
      });
    } catch (error) {
      console.error("❌ Error:", error.response?.data || error.message);
      alert("Gagal menambahkan produk!");
    }
  };

  const menuItem = [
    { id: "dashboard", label: "Dashboard", icon: Home },
    { id: "product", label: "Product", icon: LucideDog },
  ];

  const renderContent = () => {
    if (loading) {
      return (
        <div className="flex justify-center items-center py-12">
          <div className="text-gray-500">Memuat data...</div>
        </div>
      );
    }

    switch (activeTab) {
      case "dashboard":
        return (
          <Product
            handleChange={handleChange}
            handleSubmit={handleSubmit}
            formProduct={formProduct}
            setFormProduct={setFormProduct}
          />
        );
      case "product":
        return <Dashboard />;
      default:
        return (
          <Product
            handleChange={handleChange}
            handleSubmit={handleSubmit}
            formProduct={formProduct}
            setFormProduct={setFormProduct}
          />
        );
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 flex">
      {/* Sidebar */}
      <div
        className={`bg-white shadow-lg transition-all duration-300 ${
          sidebarOpen ? "w-64" : "w-20"
        }`}
      >
        <div className="p-6 border-b border-gray-200">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center">
              <Home className="h-5 w-5 text-white" />
            </div>
            {sidebarOpen && (
              <h1 className="text-xl font-bold text-gray-900">Admin Petshop</h1>
            )}
          </div>
        </div>

        <nav className="p-4">
          <div className="space-y-2">
            {menuItem.map((item) => {
              const Icon = item.icon;
              return (
                <button
                  key={item.id}
                  onClick={() => setActiveTab(item.id)}
                  className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-colors ${
                    activeTab === item.id
                      ? "bg-blue-100 text-blue-700"
                      : "text-gray-700 hover:bg-gray-100"
                  }`}
                >
                  <Icon className="h-5 w-5" />
                  {sidebarOpen && (
                    <span className="font-medium">{item.label}</span>
                  )}
                </button>
              );
            })}
          </div>
        </nav>
      </div>

      {/* Main Content */}
      <div className="flex-1 flex flex-col">
        {/* Header */}
        <header className="bg-white shadow-sm border-b border-gray-200 px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <button
                onClick={() => setSidebarOpen(!sidebarOpen)}
                className="p-2 hover:bg-gray-100 rounded-lg"
              >
                <Menu className="h-5 w-5" />
              </button>
              <h2 className="text-lg font-semibold text-gray-900">
                {menuItem.find((item) => item.id === activeTab)?.label ||
                  "Dashboard"}
              </h2>
            </div>

            <div className="flex items-center gap-4">
              <button className="p-2 hover:bg-gray-100 rounded-lg relative">
                <Bell className="h-5 w-5 text-gray-600" />
                <span className="absolute -top-1 -right-1 w-3 h-3 bg-red-500 rounded-full"></span>
              </button>
              <div className="flex items-center gap-3">
                <div className="w-8 h-8 bg-gray-300 rounded-full"></div>
                <div className="text-sm">
                  <p className="font-medium">Admin</p>
                  <p className="text-gray-500">admin@petshop.com</p>
                </div>
              </div>
            </div>
          </div>
        </header>

        {/* Content */}
        <main className="flex-1 p-6 overflow-auto">{renderContent()}</main>
      </div>
    </div>
  );
}
