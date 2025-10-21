import { useState } from "react";
import axios from "axios";
import { Home, LucideDog, Bell, Menu, Plus } from "lucide-react";

// link backend
const BASE_URL_PRODUCT = "http://localhost:5000/api/products";


function Product({ 
    handleSubmit, 
    formProduct, 
    handleChange, 
    setFormProduct,
    handleTagKeyDown, 
    removeTag,
    currentTag,
    setCurrentTag,
    // END PROPS BARU
  }) {
  
  const createPreviewUrl = (file) => {
    if (file instanceof File) {
      return URL.createObjectURL(file);
    }
    return file; 
  };

  return (
    <div className="bg-white p-4 rounded-xl shadow-md">
      <h2 className="text-xl font-semibold mb-6 text-center text-gray-800">
        Tambah Produk Baru
      </h2>
      <form onSubmit={handleSubmit} className="space-y-4">
        <input
          name="name"
          value={formProduct.name}
          onChange={handleChange}
          placeholder="Nama Product"
          className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
          required
        />
        <input
          name="slug"
          value={formProduct.slug}
          onChange={handleChange}
          placeholder="Slug (Contoh: makanan-anjing-royal-canin)"
          className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
        />
        <textarea
          name="description"
          value={formProduct.description}
          onChange={handleChange}
          placeholder="Deskripsi Produk"
          className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
          rows={3}
          required
        />
        
        {/* HARGA */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <input
            name="price"
            type="number"
            value={formProduct.price}
            onChange={handleChange}
            placeholder="Harga Produk (Rp)"
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
            required
          />
          <input
            name="comparePrice"
            type="number"
            value={formProduct.comparePrice}
            onChange={handleChange}
            placeholder="Harga Pembanding (Rp)"
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
          />
        </div>

        {/* KATEGORI & TIPE PET */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <select
            name="category"
            value={formProduct.category}
            onChange={handleChange}
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
            required
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
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
            required
          >
            <option value="">Pilih Pet</option>
            <option value="kucing">Kucing</option>
            <option value="anjing">Anjing</option>
            <option value="burung">Burung</option>
          </select>
        </div>

        <input
          name="brand"
          value={formProduct.brand}
          onChange={handleChange}
          placeholder="Brand (Merk Produk)"
          className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
        />

        {/* BERAT & STOK */}
        <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
          <input
            name="weight"
            type="number"
            value={formProduct.weight}
            onChange={handleChange}
            placeholder="Berat"
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none col-span-1"
          />
          <select
            name="unit"
            value={formProduct.unit}
            onChange={handleChange}
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none col-span-1"
          >
            <option value="">Unit</option>
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
            placeholder="Stok"
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none col-span-2"
            required
          />
        </div>

        {/* UPLOAD GAMBAR */}
        {/* ... (bagian upload gambar Anda tidak saya sentuh karena sudah benar) ... */}
        <div className="w-full border border-gray-300 p-4 rounded-lg bg-gray-50">
          <label className="block mb-3 text-sm font-medium text-gray-700">
            Upload Gambar Produk (Maks. 5)
          </label>
          <input
            name="images"
            type="file"
            multiple
            accept="image/*"
            onChange={handleChange}
            className="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-amber-50 file:text-amber-700 hover:file:bg-amber-100"
          />
          {formProduct.images.length > 0 && (
            <div className="grid grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-3 mt-4">
              {formProduct.images.map((file, index) => {
                const previewUrl = createPreviewUrl(file);
                return (
                  <div
                    key={index}
                    className="relative border border-gray-200 rounded-lg overflow-hidden shadow-sm"
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
                        URL.revokeObjectURL(previewUrl);
                      }}
                      className="absolute top-1 right-1 bg-red-600 text-white text-xs rounded-full p-1 opacity-90 hover:opacity-100 transition-opacity"
                    >
                      ✕
                    </button>
                  </div>
                );
              })}
            </div>
          )}
        </div>
        

        {/* START PERBAIKAN: INPUT TAGS SATU PER SATU (CHIP) */}
        <div className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus-within:ring-2 focus-within:ring-amber-500 focus-within:outline-none bg-white min-h-[44px]">
            <label className="block mb-2 text-sm font-medium text-gray-700 sr-only">Tags</label>
            
            {/* Kontainer untuk tags dan input, agar bisa inline */}
            <div className="flex flex-wrap items-center gap-2">
                
                {/* 1. Tampilkan Tags yang sudah ditambahkan (CHIP) */}
                {formProduct.tags.map((tag) => (
                    <span
                        key={tag}
                        className="flex items-center bg-amber-100 text-amber-800 text-sm font-medium px-3 py-1 rounded-full whitespace-nowrap"
                    >
                        {tag}
                        <button
                            type="button"
                            onClick={() => removeTag(tag)}
                            className="ml-2 text-amber-600 hover:text-amber-800 focus:outline-none"
                        >
                            ✕
                        </button>
                    </span>
                ))}
            
                {/* 2. Input untuk Tag yang Sedang Diketik */}
                <input
                    // Tidak perlu name="tags" di sini karena state diupdate manual
                    value={currentTag} 
                    onChange={(e) => setCurrentTag(e.target.value)} 
                    onKeyDown={handleTagKeyDown} // Gunakan handler untuk 'Enter'/'Koma'
                    placeholder={formProduct.tags.length === 0 ? "Ketik tag, lalu tekan Enter atau Koma" : "Tambah tag lain..."}
                    className="flex-grow border-0 p-0 focus:ring-0 focus:outline-none min-w-[100px]"
                />
            </div>
        </div>
        {/* END PERBAIKAN */}


        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <input
            name="rating"
            type="number"
            value={formProduct.rating}
            onChange={handleChange}
            max={5}
            min={0}
            step="0.1"
            placeholder="Rating (0-5)"
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
          />
          <input
            name="reviewCount"
            value={formProduct.reviewCount}
            onChange={handleChange}
            type="number"
            placeholder="Jumlah Ulasan"
            className="w-full border border-gray-300 p-3 rounded-lg text-gray-800 focus:ring-2 focus:ring-amber-500 focus:outline-none"
          />
        </div>

        <button
          type="submit" 
          className="w-full bg-amber-600 text-white font-bold py-3 px-6 rounded-lg hover:bg-amber-700 transition-colors flex items-center justify-center gap-2 mt-6"
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
    <div className="p-4 bg-white shadow-md rounded-xl">
      <h2 className="text-2xl font-bold text-gray-800">Ringkasan Dashboard</h2>
      <p className="mt-2 text-gray-600">
        Ini adalah tampilan utama dashboard. Di sini Anda bisa menampilkan
        statistik, ringkasan pesanan, dan informasi penting lainnya.
      </p>

    </div>
  );
}

export default function AdminPetshop() {
  const [activeTab, setActiveTab] = useState("dashboard");
  const [loading, setLoading] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const [currentTag, setCurrentTag] = useState("");
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
    isAvailable: true, // Nilai default boolean
  });

  const handleChange = (e) => {
    const { name, value, files, type } = e.target;

    if (name === "images") {
      const newFiles = Array.from(files);
      setFormProduct((prev) => ({
        ...prev,
        images: [...prev.images, ...newFiles].slice(0, 5),
      }));
    } else if (name === "tags") {

      setFormProduct((prev) => ({
            ...prev,

            tags: value.split(" ").map((tag) => tag.trim()).filter((tag) => tag.length > 0)
        }));
    } else if (type === "checkbox") {
      setFormProduct((prev) => ({
        ...prev,
        [name]: e.target.checked,
      }));
    } else if (type === "number") {

      setFormProduct((prev) => ({
        ...prev,
        [name]: value,
      }));
    } else {
      setFormProduct((prev) => ({
        ...prev,
        [name]: value,
      }));
    }
  };


const handleTagKeyDown = (e) => {

    if (e.key === 'Enter' || e.key === ',') {
        e.preventDefault();
        
        const newTag = currentTag.trim();

        if (newTag && !formProduct.tags.includes(newTag)) {
            setFormProduct((prev) => ({
                ...prev,
                tags: [...prev.tags, newTag], 
            }));
            setCurrentTag(""); 
        }
    }
};


const removeTag = (tagToRemove) => {
    setFormProduct((prev) => ({
        ...prev,
        tags: prev.tags.filter(tag => tag !== tagToRemove),
    }));
};

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);

    try {
      const formData = new FormData();


      for (const key in formProduct) {
        if (key !== "images" && key !== "tags") {
          formData.append(key, formProduct[key]);
        }
      }

      formProduct.tags.forEach((tag) => {
        formData.append("tags", tag);
      });
      // Menambahkan file gambar ke formData
      formProduct.images.forEach((file) => {
        formData.append("images", file);
      });

      const response = await axios.post(BASE_URL_PRODUCT, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      });

      alert("✅ Produk berhasil ditambahkan!");

      // Reset form setelah berhasil
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
      // Mengarahkan ke tab Product setelah submit
      setActiveTab("product");
    } catch (error) {
      console.error("❌ Error:", error.response?.data || error.message);
      alert(
        `Gagal menambahkan produk! ${
          error.response?.data?.message || "Cek console log untuk detail."
        }`
      );
    } finally {
      setLoading(false);
    }
  };

  const menuItem = [
    { id: "dashboard", label: "Dashboard", icon: Home },
    { id: "product", label: "Tambah Produk", icon: Plus }, // Mengubah label "Product" menjadi "Tambah Produk" agar sesuai dengan Product component
    { id: "data_product", label: "Data Produk", icon: LucideDog },
  ];

  const renderContent = () => {
    if (loading) {
      return (
        <div className="flex justify-center items-center py-12">
          <div className="text-lg text-gray-500 font-medium">
            Sedang memproses data...
          </div>
        </div>
      );
    }

    switch (activeTab) {
      case "dashboard":
        return <Dashboard />;
      case "product": // Jika ingin menambah produk
        return (
          <Product
            handleChange={handleChange}
            handleSubmit={handleSubmit}
            formProduct={formProduct}
            setFormProduct={setFormProduct}
            setCurrentTag={setCurrentTag}
            removeTag={removeTag}
            handleTagKeyDown={handleTagKeyDown}
            currentTag={currentTag}
          />
        );
      case "data_product": // Asumsi tab ini untuk menampilkan list produk
        return (
          <div className="p-4 bg-white shadow-md rounded-xl">
            <h2 className="text-2xl font-bold text-gray-800">Data Produk</h2>
            <p className="mt-2 text-gray-600">
              Ini adalah tempat untuk menampilkan dan mengelola daftar produk
              Anda.
            </p>
          </div>
        );
      default:
        return <Dashboard />;
    }
  };

  return (
    <div className="min-h-screen bg-gray-100 flex">
      {/* Sidebar */}
      <div
        className={`bg-white shadow-lg transition-all duration-300 ${
          sidebarOpen ? "w-64" : "w-20"
        } sticky top-0 h-screen overflow-y-auto`}
      >
        <div className="p-6 border-b border-gray-200">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 bg-amber-600 rounded-lg flex items-center justify-center">
              <LucideDog className="h-5 w-5 text-white" />
            </div>
            {sidebarOpen && (
              <h1 className="text-xl font-bold text-gray-900 transition-opacity duration-300">
                Admin Petshop
              </h1>
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
                      ? "bg-amber-100 text-amber-700 font-semibold"
                      : "text-gray-700 hover:bg-gray-100"
                  }`}
                >
                  <Icon className="h-5 w-5" />
                  {sidebarOpen && (
                    <span className="font-medium transition-opacity duration-300">
                      {item.label}
                    </span>
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
        <header className="bg-white shadow-md border-b border-gray-200 px-6 py-4 sticky top-0 z-10">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-4">
              <button
                onClick={() => setSidebarOpen(!sidebarOpen)}
                className="p-2 hover:bg-gray-100 rounded-lg text-gray-600"
              >
                <Menu className="h-5 w-5" />
              </button>
              <h2 className="text-xl font-semibold text-gray-900">
                {menuItem.find((item) => item.id === activeTab)?.label ||
                  "Dashboard"}
              </h2>
            </div>

            <div className="flex items-center gap-4">
              <button className="p-2 hover:bg-gray-100 rounded-lg relative text-gray-600">
                <Bell className="h-5 w-5" />
                <span className="absolute -top-1 -right-1 w-3 h-3 bg-red-500 border border-white rounded-full"></span>
              </button>
              <div className="flex items-center gap-3">
                <div className="w-9 h-9 bg-amber-300 rounded-full flex items-center justify-center text-amber-800 font-bold text-sm">
                  A
                </div>
                <div className="text-sm hidden md:block">
                  <p className="font-medium text-gray-800">Admin</p>
                  <p className="text-gray-500">admin@petshop.com</p>
                </div>
              </div>
            </div>
          </div>
        </header>

        {/* Content */}
        <main className="flex-1 p-6 overflow-auto bg-gray-50">
          {renderContent()}
        </main>
      </div>
    </div>
  );
}
