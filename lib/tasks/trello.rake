
require 'dotenv/load'
require File.expand_path('../trello/trello', __dir__)

namespace :trello do
  desc 'Run Trello tasks'
  task :run do |t, args|
    puts "T: #{ENV['TRELLO_API_KEY']}"

    options = {
      apiKey: ENV['TRELLO_API_KEY'],
      token: ENV['TRELLO_TOKEN'],
      events: [{
        name: 'Menteludic Villalba - Marzo 2020',
        start_date: '2020-03-13 18:00',
        end_date: '2020-03-15 22:00',
        boardId: 'CXC2KNYl',
        labelId: '5e1ef752a3d77f7ef395701a',
        mapUrl: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3027.8832673569714!2d-4.009489384380205!3d40.63245625041449!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0xd4174147b8d72cd%3A0x2c0bc70ee0dc7858!2sCarpa%20de%20la%20Malvaloca!5e0!3m2!1ses!2ses!4v1581704859423!5m2!1ses!2ses',
        desc: '<h3>Juegos de Mesa, Rol, Cómic</h3><p>Ilustradores - Actividades para niños - Juegos Gigantes - Talleres - Torneos - Sorteos - Cosplayers... <b>¡Y MUCHO MAS!</b></p>',
        mapDesc: {
          title: 'Carpa de la Malvaloca',
          description: 'Calle Batalla de Bailén',
          extra: '28400 Collado Villalba, Madrid'
        },
        datesDesc: {
          title: '13, 14 y 15 de Marzo de 2020',
          items: [
            'Viernes 13 de 18:00 a 22:00',
            'Sábado 14 de 11:00 a 14:30 y de 16:00 a 22:00',
            'Domingo 15 de 11:00 a 14:30 y de 16:00 a 20:00'
          ]
        }

      }]
    }
    Trello::Main.call(options)
  end
end
