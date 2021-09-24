aspect|structured|un-structured
:--|:--|:--
 brief|quantitative|qualitative
 Sources|OLTP systems, online forms, logs, etc.|messages, documents, interview transcripts
 Forms|numbers and values|text, audio, video, sensors
 Models|(schema-on-write)has predefined data model, formatted to a set data structure before being placed in data storage|(schema-on-read)stored in native format and not processed until when used  
 Storage|tabular formats (sheets/SQL databases), in data warehouses which makes it highly scalable|NoSQL databases/media files, stored in data lakes which makes it difficult to scale
 Uses|used in ML and drives its algorithms|NLP and text mining