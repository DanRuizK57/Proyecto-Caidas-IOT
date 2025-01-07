import express from "express";
import fetch from "node-fetch";

const app = express();
const PORT = 3000;

app.use(express.json()); // Middleware para parsear JSON

// Variables con los endpoints y los datos estáticos
const endpointPost = "http://iot.ceisufro.cl:8080/api/auth/login";
const datosPost = {
  username: "user",
  password: "pass",
};
const endpointGet =
  "http://iot.ceisufro.cl:8080/api/plugins/telemetry/DEVICE/id/values/timeseries?keys=val_x,val_y,buttonStat";

// Servicio para obtener el token
async function obtenerToken(endpoint, datos) {
  try {
    const respuesta = await fetch(endpoint, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(datos),
    });

    if (!respuesta.ok) {
      throw new Error(
        `Error en la solicitud: ${respuesta.status} - ${respuesta.statusText}`
      );
    }

    const respuestaJson = await respuesta.json();
    return respuestaJson.token;
  } catch (error) {
    throw new Error(`Error al obtener el token: ${error.message}`);
  }
}

async function realizarGetConToken(endpoint, token) {
  try {
    const respuesta = await fetch(endpoint, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    if (!respuesta.ok) {
      throw new Error(
        `Error en la solicitud GET: ${respuesta.status} - ${respuesta.statusText}`
      );
    }

    const respuestaJson = await respuesta.json();
    return respuestaJson;
  } catch (error) {
    throw new Error(`Error al realizar el GET: ${error.message}`);
  }
}

//
app.get("/obtener-datos", async (req, res) => {
  try {
    // token con los datos
    const token = await obtenerToken(endpointPost, datosPost);

    if (!token) {
      return res
        .status(400)
        .json({ error: "No se encontró el token en la respuesta" });
    }

    const datos = await realizarGetConToken(endpointGet, token);

    res.status(200).json({ datos });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor ejecutándose en http://localhost:${PORT}`);
});
