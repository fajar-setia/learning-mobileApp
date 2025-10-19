import { useState } from "react";
import { Home, LucideDog, Bell, Menu } from "lucide-react";

function Dashboard() {
  return (
    <div className="bg-amber-800 p-4 text-white rounded-xl">
      <p>Halo, ini bagian dashboard</p>
    </div>
  );
}

function Product() {
  return (
    <div className="p-4">
      <p>Ini bagian product</p>
    </div>
  );
}

export default function AdminPetshop() {
  const [activeTab, setActiveTab] = useState<string>("dashboard");
  const [loading] = useState(false);
  const [sidebarOpen, setSidebarOpen] = useState(true);
  

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
        return <Dashboard />;
      case "product":
        return <Product />;
      default:
        return <Dashboard />;
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
                  {sidebarOpen && <span className="font-medium">{item.label}</span>}
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
