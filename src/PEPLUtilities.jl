module PEPLUtilities
using Unitful, PhysicalConstants

const k_B = PhysicalConstants.CODATA2018.k_B

export @Te_func

const ARGON_DENSITY_STP     = 1.78u"kg/m^3"
const KRYPTON_DENSITY_STP   = 3.749u"kg/m^3"
const XENON_DENSITY_STP     = 5.894u"kg/m^3"

@unit sccm      "sccm"      STPCubicCmPerMinute     1u"cm^3/minute"                         true
@unit sccmAr    "sccmAr"    STPCubicCmPerMinuteAr   1u"cm^3/minute" * ARGON_DENSITY_STP     true
@unit sccmKr    "sccmKr"    STPCubicCmPerMinuteKr   1u"cm^3/minute" * KRYPTON_DENSITY_STP   true
@unit sccmXe    "sccmXe"    STPCubicCmPerMinuteXe   1u"cm^3/minute" * XENON_DENSITY_STP     true

function __init__()
    Unitful.register(PEPLUtilities)
end


macro Te_func(fndef)
    fnname = fndef.args[1].args[1]
    @show fnname
    var = gensym()
    esc(quote
        $fndef;
        $(fnname)($(var)::Unitful.Temperature) = $(fnname)($(k_B) * $(var))
    end)
end

end
