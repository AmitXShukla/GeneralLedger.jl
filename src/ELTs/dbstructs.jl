##############################################################################
# 
# ERP Records mostly have few common ELT specific metadata fields (subrecords)
# 
##############################################################################

mutable struct SubRecordINSMetadata
    source::String
    createDTTM::String
    updateDTTM::String
    author::String
end

mutable struct SubRecordUPDMetadata
    source::String
    updateDTTM::String
    author::String
end

"""
SubRecordINSMetadata(source::String, createDTTM::String, updateDTTM::String, author::String)

Stores metadata about records/document loaded into data lake.
...
# Arguments
- `source::String`: stores SOR (system of record i.e. source) name
- `createDTTM::String` : data & time when data was first loaded.
- `updateDTTM::String` : data & time when data was last updated (equals to createDTTM in case of no updates).
- `author::String` : name of the person responsible for loading data.
...
"""
SubRecordINSMetadata() = SubRecordINSMetadata(
    "-",
    Dates.now(),
    Dates.now(),
    "-"
)

"""
SubRecordUPDMetadata(source::String, updateDTTM::String, author::String)

Stores metadata about records/document loaded into data lake.
...
# Arguments
- `source::String`: stores SOR (system of record i.e. source) name
- `updateDTTM::String` : data & time when data was last updated (equals to createDTTM in case of no updates).
- `author::String` : name of the person responsible for loading data.
...
"""
SubRecordUPDMetadata() = SubRecordUPDMetadata(
    "-",
    Dates.now(),
    "-"
)

##############################################################################
# 
# Define ERP Record structures
# 
##############################################################################
abstract type ELTDocument; end

mutable struct account <: ELTDocument
    id::Int32
    status::String
    descr::String
    clssfctn::String
    category::String
    type::String
    comments::String
    subrec::SubRecordINSMetadata
end


mutable struct department <: ELTDocument
    id::Int32
    status::String
    descr::String
    clssfctn::String
    category::String
    type::String
    comments::String
    subrec::SubRecordINSMetadata
end

mutable struct location <: ELTDocument
    id::Int32
    status::String
    descr::String
    clssfctn::String
    category::String
    type::String
    comments::String
    subrec::SubRecordINSMetadata
end

mutable struct costcenter <: ELTDocument
    id::Int32
    status::String
    descr::String
    clssfctn::String
    category::String
    type::String
    comments::String
    subrec::SubRecordINSMetadata
end

mutable struct operunit <: ELTDocument
    id::Int32
    status::String
    descr::String
    clssfctn::String
    category::String
    type::String
    comments::String
    subrec::SubRecordINSMetadata
end

mutable struct ledger <: ELTDocument
    id::Int32
    status::String
    descr::String
    clssfctn::String
    category::String
    type::String
    comments::String
    subrec::SubRecordINSMetadata
end