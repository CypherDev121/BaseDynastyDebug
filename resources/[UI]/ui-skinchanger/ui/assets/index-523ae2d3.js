(function () {
    const t = document.createElement("link").relList;
    if (t && t.supports && t.supports("modulepreload")) return;
    for (const i of document.querySelectorAll('link[rel="modulepreload"]')) n(i);
    new MutationObserver(i => {
        for (const r of i)
            if (r.type === "childList")
                for (const o of r.addedNodes) o.tagName === "LINK" && o.rel === "modulepreload" && n(o)
    }).observe(document, {
        childList: !0,
        subtree: !0
    });

    function s(i) {
        const r = {};
        return i.integrity && (r.integrity = i.integrity), i.referrerPolicy && (r.referrerPolicy = i.referrerPolicy), i.crossOrigin === "use-credentials" ? r.credentials = "include" : i.crossOrigin === "anonymous" ? r.credentials = "omit" : r.credentials = "same-origin", r
    }

    function n(i) {
        if (i.ep) return;
        i.ep = !0;
        const r = s(i);
        fetch(i.href, r)
    }
})();

function Cs(e, t) {
    const s = Object.create(null),
        n = e.split(",");
    for (let i = 0; i < n.length; i++) s[n[i]] = !0;
    return t ? i => !!s[i.toLowerCase()] : i => !!s[i]
}
const j = {},
    Qe = [],
    de = () => { },
    vi = () => !1,
    xi = /^on[^a-z]/,
    Ut = e => xi.test(e),
    ws = e => e.startsWith("onUpdate:"),
    Z = Object.assign,
    Es = (e, t) => {
        const s = e.indexOf(t);
        s > -1 && e.splice(s, 1)
    },
    Ci = Object.prototype.hasOwnProperty,
    R = (e, t) => Ci.call(e, t),
    O = Array.isArray,
    Ve = e => qt(e) === "[object Map]",
    Sn = e => qt(e) === "[object Set]",
    A = e => typeof e == "function",
    q = e => typeof e == "string",
    Wt = e => typeof e == "symbol",
    H = e => e !== null && typeof e == "object",
    Tn = e => (H(e) || A(e)) && A(e.then) && A(e.catch),
    On = Object.prototype.toString,
    qt = e => On.call(e),
    wi = e => qt(e).slice(8, -1),
    Pn = e => qt(e) === "[object Object]",
    Ss = e => q(e) && e !== "NaN" && e[0] !== "-" && "" + parseInt(e, 10) === e,
    Lt = Cs(",key,ref,ref_for,ref_key,onVnodeBeforeMount,onVnodeMounted,onVnodeBeforeUpdate,onVnodeUpdated,onVnodeBeforeUnmount,onVnodeUnmounted"),
    zt = e => {
        const t = Object.create(null);
        return s => t[s] || (t[s] = e(s))
    },
    Ei = /-(\w)/g,
    Ge = zt(e => e.replace(Ei, (t, s) => s ? s.toUpperCase() : "")),
    Si = /\B([A-Z])/g,
    nt = zt(e => e.replace(Si, "-$1").toLowerCase()),
    In = zt(e => e.charAt(0).toUpperCase() + e.slice(1)),
    ns = zt(e => e ? `on${In(e)}` : ""),
    Ue = (e, t) => !Object.is(e, t),
    is = (e, t) => {
        for (let s = 0; s < e.length; s++) e[s](t)
    },
    Nt = (e, t, s) => {
        Object.defineProperty(e, t, {
            configurable: !0,
            enumerable: !1,
            value: s
        })
    },
    Ti = e => {
        const t = parseFloat(e);
        return isNaN(t) ? e : t
    };
let Ys;
const fs = () => Ys || (Ys = typeof globalThis < "u" ? globalThis : typeof self < "u" ? self : typeof window < "u" ? window : typeof global < "u" ? global : {});

function Jt(e) {
    if (O(e)) {
        const t = {};
        for (let s = 0; s < e.length; s++) {
            const n = e[s],
                i = q(n) ? Ai(n) : Jt(n);
            if (i)
                for (const r in i) t[r] = i[r]
        }
        return t
    } else if (q(e) || H(e)) return e
}
const Oi = /;(?![^(]*\))/g,
    Pi = /:([^]+)/,
    Ii = /\/\*[^]*?\*\//g;

function Ai(e) {
    const t = {};
    return e.replace(Ii, "").split(Oi).forEach(s => {
        if (s) {
            const n = s.split(Pi);
            n.length > 1 && (t[n[0].trim()] = n[1].trim())
        }
    }), t
}

function Ee(e) {
    let t = "";
    if (q(e)) t = e;
    else if (O(e))
        for (let s = 0; s < e.length; s++) {
            const n = Ee(e[s]);
            n && (t += n + " ")
        } else if (H(e))
        for (const s in e) e[s] && (t += s + " ");
    return t.trim()
}
const Mi = "itemscope,allowfullscreen,formnovalidate,ismap,nomodule,novalidate,readonly",
    Li = Cs(Mi);

function An(e) {
    return !!e || e === ""
}
const ce = e => q(e) ? e : e == null ? "" : O(e) || H(e) && (e.toString === On || !A(e.toString)) ? JSON.stringify(e, Mn, 2) : String(e),
    Mn = (e, t) => t && t.__v_isRef ? Mn(e, t.value) : Ve(t) ? {
        [`Map(${t.size})`]: [...t.entries()].reduce((s, [n, i]) => (s[`${n} =>`] = i, s), {})
    } : Sn(t) ? {
        [`Set(${t.size})`]: [...t.values()]
    } : H(t) && !O(t) && !Pn(t) ? String(t) : t;
let ae;
class Ln {
    constructor(t = !1) {
        this.detached = t, this._active = !0, this.effects = [], this.cleanups = [], this.parent = ae, !t && ae && (this.index = (ae.scopes || (ae.scopes = [])).push(this) - 1)
    }
    get active() {
        return this._active
    }
    run(t) {
        if (this._active) {
            const s = ae;
            try {
                return ae = this, t()
            } finally {
                ae = s
            }
        }
    }
    on() {
        ae = this
    }
    off() {
        ae = this.parent
    }
    stop(t) {
        if (this._active) {
            let s, n;
            for (s = 0, n = this.effects.length; s < n; s++) this.effects[s].stop();
            for (s = 0, n = this.cleanups.length; s < n; s++) this.cleanups[s]();
            if (this.scopes)
                for (s = 0, n = this.scopes.length; s < n; s++) this.scopes[s].stop(!0);
            if (!this.detached && this.parent && !t) {
                const i = this.parent.scopes.pop();
                i && i !== this && (this.parent.scopes[this.index] = i, i.index = this.index)
            }
            this.parent = void 0, this._active = !1
        }
    }
}

function Di(e) {
    return new Ln(e)
}

function Ri(e, t = ae) {
    t && t.active && t.effects.push(e)
}

function Fi() {
    return ae
}
const Ts = e => {
    const t = new Set(e);
    return t.w = 0, t.n = 0, t
},
    Dn = e => (e.w & Le) > 0,
    Rn = e => (e.n & Le) > 0,
    ki = ({
        deps: e
    }) => {
        if (e.length)
            for (let t = 0; t < e.length; t++) e[t].w |= Le
    },
    Ni = e => {
        const {
            deps: t
        } = e;
        if (t.length) {
            let s = 0;
            for (let n = 0; n < t.length; n++) {
                const i = t[n];
                Dn(i) && !Rn(i) ? i.delete(e) : t[s++] = i, i.w &= ~Le, i.n &= ~Le
            }
            t.length = s
        }
    },
    us = new WeakMap;
let ut = 0,
    Le = 1;
const ds = 30;
let fe;
const He = Symbol(""),
    hs = Symbol("");
class Os {
    constructor(t, s = null, n) {
        this.fn = t, this.scheduler = s, this.active = !0, this.deps = [], this.parent = void 0, Ri(this, n)
    }
    run() {
        if (!this.active) return this.fn();
        let t = fe,
            s = Ae;
        for (; t;) {
            if (t === this) return;
            t = t.parent
        }
        try {
            return this.parent = fe, fe = this, Ae = !0, Le = 1 << ++ut, ut <= ds ? ki(this) : $s(this), this.fn()
        } finally {
            ut <= ds && Ni(this), Le = 1 << --ut, fe = this.parent, Ae = s, this.parent = void 0, this.deferStop && this.stop()
        }
    }
    stop() {
        fe === this ? this.deferStop = !0 : this.active && ($s(this), this.onStop && this.onStop(), this.active = !1)
    }
}

function $s(e) {
    const {
        deps: t
    } = e;
    if (t.length) {
        for (let s = 0; s < t.length; s++) t[s].delete(e);
        t.length = 0
    }
}
let Ae = !0;
const Fn = [];

function it() {
    Fn.push(Ae), Ae = !1
}

function rt() {
    const e = Fn.pop();
    Ae = e === void 0 ? !0 : e
}

function re(e, t, s) {
    if (Ae && fe) {
        let n = us.get(e);
        n || us.set(e, n = new Map);
        let i = n.get(s);
        i || n.set(s, i = Ts()), kn(i)
    }
}

function kn(e, t) {
    let s = !1;
    ut <= ds ? Rn(e) || (e.n |= Le, s = !Dn(e)) : s = !e.has(fe), s && (e.add(fe), fe.deps.push(e))
}

function Se(e, t, s, n, i, r) {
    const o = us.get(e);
    if (!o) return;
    let c = [];
    if (t === "clear") c = [...o.values()];
    else if (s === "length" && O(e)) {
        const f = Number(n);
        o.forEach((u, m) => {
            (m === "length" || !Wt(m) && m >= f) && c.push(u)
        })
    } else switch (s !== void 0 && c.push(o.get(s)), t) {
        case "add":
            O(e) ? Ss(s) && c.push(o.get("length")) : (c.push(o.get(He)), Ve(e) && c.push(o.get(hs)));
            break;
        case "delete":
            O(e) || (c.push(o.get(He)), Ve(e) && c.push(o.get(hs)));
            break;
        case "set":
            Ve(e) && c.push(o.get(He));
            break
    }
    if (c.length === 1) c[0] && ps(c[0]);
    else {
        const f = [];
        for (const u of c) u && f.push(...u);
        ps(Ts(f))
    }
}

function ps(e, t) {
    const s = O(e) ? e : [...e];
    for (const n of s) n.computed && Qs(n);
    for (const n of s) n.computed || Qs(n)
}

function Qs(e, t) {
    (e !== fe || e.allowRecurse) && (e.scheduler ? e.scheduler() : e.run())
}
const Bi = Cs("__proto__,__v_isRef,__isVue"),
    Nn = new Set(Object.getOwnPropertyNames(Symbol).filter(e => e !== "arguments" && e !== "caller").map(e => Symbol[e]).filter(Wt)),
    Vs = ji();

function ji() {
    const e = {};
    return ["includes", "indexOf", "lastIndexOf"].forEach(t => {
        e[t] = function (...s) {
            const n = F(this);
            for (let r = 0, o = this.length; r < o; r++) re(n, "get", r + "");
            const i = n[t](...s);
            return i === -1 || i === !1 ? n[t](...s.map(F)) : i
        }
    }), ["push", "pop", "shift", "unshift", "splice"].forEach(t => {
        e[t] = function (...s) {
            it();
            const n = F(this)[t].apply(this, s);
            return rt(), n
        }
    }), e
}

function Hi(e) {
    const t = F(this);
    return re(t, "has", e), t.hasOwnProperty(e)
}
class Bn {
    constructor(t = !1, s = !1) {
        this._isReadonly = t, this._shallow = s
    }
    get(t, s, n) {
        const i = this._isReadonly,
            r = this._shallow;
        if (s === "__v_isReactive") return !i;
        if (s === "__v_isReadonly") return i;
        if (s === "__v_isShallow") return r;
        if (s === "__v_raw" && n === (i ? r ? Gi : Un : r ? Kn : Hn).get(t)) return t;
        const o = O(t);
        if (!i) {
            if (o && R(Vs, s)) return Reflect.get(Vs, s, n);
            if (s === "hasOwnProperty") return Hi
        }
        const c = Reflect.get(t, s, n);
        return (Wt(s) ? Nn.has(s) : Bi(s)) || (i || re(t, "get", s), r) ? c : X(c) ? o && Ss(s) ? c : c.value : H(c) ? i ? Wn(c) : As(c) : c
    }
}
class jn extends Bn {
    constructor(t = !1) {
        super(!1, t)
    }
    set(t, s, n, i) {
        let r = t[s];
        if (et(r) && X(r) && !X(n)) return !1;
        if (!this._shallow && (!Bt(n) && !et(n) && (r = F(r), n = F(n)), !O(t) && X(r) && !X(n))) return r.value = n, !0;
        const o = O(t) && Ss(s) ? Number(s) < t.length : R(t, s),
            c = Reflect.set(t, s, n, i);
        return t === F(i) && (o ? Ue(n, r) && Se(t, "set", s, n) : Se(t, "add", s, n)), c
    }
    deleteProperty(t, s) {
        const n = R(t, s);
        t[s];
        const i = Reflect.deleteProperty(t, s);
        return i && n && Se(t, "delete", s, void 0), i
    }
    has(t, s) {
        const n = Reflect.has(t, s);
        return (!Wt(s) || !Nn.has(s)) && re(t, "has", s), n
    }
    ownKeys(t) {
        return re(t, "iterate", O(t) ? "length" : He), Reflect.ownKeys(t)
    }
}
class Ki extends Bn {
    constructor(t = !1) {
        super(!0, t)
    }
    set(t, s) {
        return !0
    }
    deleteProperty(t, s) {
        return !0
    }
}
const Ui = new jn,
    Wi = new Ki,
    qi = new jn(!0),
    Ps = e => e,
    Yt = e => Reflect.getPrototypeOf(e);

function St(e, t, s = !1, n = !1) {
    e = e.__v_raw;
    const i = F(e),
        r = F(t);
    s || (Ue(t, r) && re(i, "get", t), re(i, "get", r));
    const {
        has: o
    } = Yt(i), c = n ? Ps : s ? Ds : mt;
    if (o.call(i, t)) return c(e.get(t));
    if (o.call(i, r)) return c(e.get(r));
    e !== i && e.get(t)
}

function Tt(e, t = !1) {
    const s = this.__v_raw,
        n = F(s),
        i = F(e);
    return t || (Ue(e, i) && re(n, "has", e), re(n, "has", i)), e === i ? s.has(e) : s.has(e) || s.has(i)
}

function Ot(e, t = !1) {
    return e = e.__v_raw, !t && re(F(e), "iterate", He), Reflect.get(e, "size", e)
}

function Xs(e) {
    e = F(e);
    const t = F(this);
    return Yt(t).has.call(t, e) || (t.add(e), Se(t, "add", e, e)), this
}

function Zs(e, t) {
    t = F(t);
    const s = F(this),
        {
            has: n,
            get: i
        } = Yt(s);
    let r = n.call(s, e);
    r || (e = F(e), r = n.call(s, e));
    const o = i.call(s, e);
    return s.set(e, t), r ? Ue(t, o) && Se(s, "set", e, t) : Se(s, "add", e, t), this
}

function Gs(e) {
    const t = F(this),
        {
            has: s,
            get: n
        } = Yt(t);
    let i = s.call(t, e);
    i || (e = F(e), i = s.call(t, e)), n && n.call(t, e);
    const r = t.delete(e);
    return i && Se(t, "delete", e, void 0), r
}

function en() {
    const e = F(this),
        t = e.size !== 0,
        s = e.clear();
    return t && Se(e, "clear", void 0, void 0), s
}

function Pt(e, t) {
    return function (n, i) {
        const r = this,
            o = r.__v_raw,
            c = F(o),
            f = t ? Ps : e ? Ds : mt;
        return !e && re(c, "iterate", He), o.forEach((u, m) => n.call(i, f(u), f(m), r))
    }
}

function It(e, t, s) {
    return function (...n) {
        const i = this.__v_raw,
            r = F(i),
            o = Ve(r),
            c = e === "entries" || e === Symbol.iterator && o,
            f = e === "keys" && o,
            u = i[e](...n),
            m = s ? Ps : t ? Ds : mt;
        return !t && re(r, "iterate", f ? hs : He), {
            next() {
                const {
                    value: x,
                    done: w
                } = u.next();
                return w ? {
                    value: x,
                    done: w
                } : {
                    value: c ? [m(x[0]), m(x[1])] : m(x),
                    done: w
                }
            },
            [Symbol.iterator]() {
                return this
            }
        }
    }
}

function Pe(e) {
    return function (...t) {
        return e === "delete" ? !1 : e === "clear" ? void 0 : this
    }
}

function zi() {
    const e = {
        get(r) {
            return St(this, r)
        },
        get size() {
            return Ot(this)
        },
        has: Tt,
        add: Xs,
        set: Zs,
        delete: Gs,
        clear: en,
        forEach: Pt(!1, !1)
    },
        t = {
            get(r) {
                return St(this, r, !1, !0)
            },
            get size() {
                return Ot(this)
            },
            has: Tt,
            add: Xs,
            set: Zs,
            delete: Gs,
            clear: en,
            forEach: Pt(!1, !0)
        },
        s = {
            get(r) {
                return St(this, r, !0)
            },
            get size() {
                return Ot(this, !0)
            },
            has(r) {
                return Tt.call(this, r, !0)
            },
            add: Pe("add"),
            set: Pe("set"),
            delete: Pe("delete"),
            clear: Pe("clear"),
            forEach: Pt(!0, !1)
        },
        n = {
            get(r) {
                return St(this, r, !0, !0)
            },
            get size() {
                return Ot(this, !0)
            },
            has(r) {
                return Tt.call(this, r, !0)
            },
            add: Pe("add"),
            set: Pe("set"),
            delete: Pe("delete"),
            clear: Pe("clear"),
            forEach: Pt(!0, !0)
        };
    return ["keys", "values", "entries", Symbol.iterator].forEach(r => {
        e[r] = It(r, !1, !1), s[r] = It(r, !0, !1), t[r] = It(r, !1, !0), n[r] = It(r, !0, !0)
    }), [e, s, t, n]
}
const [Ji, Yi, $i, Qi] = zi();

function Is(e, t) {
    const s = t ? e ? Qi : $i : e ? Yi : Ji;
    return (n, i, r) => i === "__v_isReactive" ? !e : i === "__v_isReadonly" ? e : i === "__v_raw" ? n : Reflect.get(R(s, i) && i in n ? s : n, i, r)
}
const Vi = {
    get: Is(!1, !1)
},
    Xi = {
        get: Is(!1, !0)
    },
    Zi = {
        get: Is(!0, !1)
    },
    Hn = new WeakMap,
    Kn = new WeakMap,
    Un = new WeakMap,
    Gi = new WeakMap;

function er(e) {
    switch (e) {
        case "Object":
        case "Array":
            return 1;
        case "Map":
        case "Set":
        case "WeakMap":
        case "WeakSet":
            return 2;
        default:
            return 0
    }
}

function tr(e) {
    return e.__v_skip || !Object.isExtensible(e) ? 0 : er(wi(e))
}

function As(e) {
    return et(e) ? e : Ms(e, !1, Ui, Vi, Hn)
}

function sr(e) {
    return Ms(e, !1, qi, Xi, Kn)
}

function Wn(e) {
    return Ms(e, !0, Wi, Zi, Un)
}

function Ms(e, t, s, n, i) {
    if (!H(e) || e.__v_raw && !(t && e.__v_isReactive)) return e;
    const r = i.get(e);
    if (r) return r;
    const o = tr(e);
    if (o === 0) return e;
    const c = new Proxy(e, o === 2 ? n : s);
    return i.set(e, c), c
}

function Xe(e) {
    return et(e) ? Xe(e.__v_raw) : !!(e && e.__v_isReactive)
}

function et(e) {
    return !!(e && e.__v_isReadonly)
}

function Bt(e) {
    return !!(e && e.__v_isShallow)
}

function qn(e) {
    return Xe(e) || et(e)
}

function F(e) {
    const t = e && e.__v_raw;
    return t ? F(t) : e
}

function Ls(e) {
    return Nt(e, "__v_skip", !0), e
}
const mt = e => H(e) ? As(e) : e,
    Ds = e => H(e) ? Wn(e) : e;

function zn(e) {
    Ae && fe && (e = F(e), kn(e.dep || (e.dep = Ts())))
}

function Jn(e, t) {
    e = F(e);
    const s = e.dep;
    s && ps(s)
}

function X(e) {
    return !!(e && e.__v_isRef === !0)
}

function nr(e) {
    return ir(e, !1)
}

function ir(e, t) {
    return X(e) ? e : new rr(e, t)
}
class rr {
    constructor(t, s) {
        this.__v_isShallow = s, this.dep = void 0, this.__v_isRef = !0, this._rawValue = s ? t : F(t), this._value = s ? t : mt(t)
    }
    get value() {
        return zn(this), this._value
    }
    set value(t) {
        const s = this.__v_isShallow || Bt(t) || et(t);
        t = s ? t : F(t), Ue(t, this._rawValue) && (this._rawValue = t, this._value = s ? t : mt(t), Jn(this))
    }
}

function or(e) {
    return X(e) ? e.value : e
}
const lr = {
    get: (e, t, s) => or(Reflect.get(e, t, s)),
    set: (e, t, s, n) => {
        const i = e[t];
        return X(i) && !X(s) ? (i.value = s, !0) : Reflect.set(e, t, s, n)
    }
};

function Yn(e) {
    return Xe(e) ? e : new Proxy(e, lr)
}
class cr {
    constructor(t, s, n, i) {
        this._setter = s, this.dep = void 0, this.__v_isRef = !0, this.__v_isReadonly = !1, this._dirty = !0, this.effect = new Os(t, () => {
            this._dirty || (this._dirty = !0, Jn(this))
        }), this.effect.computed = this, this.effect.active = this._cacheable = !i, this.__v_isReadonly = n
    }
    get value() {
        const t = F(this);
        return zn(t), (t._dirty || !t._cacheable) && (t._dirty = !1, t._value = t.effect.run()), t._value
    }
    set value(t) {
        this._setter(t)
    }
}

function ar(e, t, s = !1) {
    let n, i;
    const r = A(e);
    return r ? (n = e, i = de) : (n = e.get, i = e.set), new cr(n, i, r || !i, s)
}

function Me(e, t, s, n) {
    let i;
    try {
        i = n ? e(...n) : e()
    } catch (r) {
        $t(r, t, s)
    }
    return i
}

function he(e, t, s, n) {
    if (A(e)) {
        const r = Me(e, t, s, n);
        return r && Tn(r) && r.catch(o => {
            $t(o, t, s)
        }), r
    }
    const i = [];
    for (let r = 0; r < e.length; r++) i.push(he(e[r], t, s, n));
    return i
}

function $t(e, t, s, n = !0) {
    const i = t ? t.vnode : null;
    if (t) {
        let r = t.parent;
        const o = t.proxy,
            c = s;
        for (; r;) {
            const u = r.ec;
            if (u) {
                for (let m = 0; m < u.length; m++)
                    if (u[m](e, o, c) === !1) return
            }
            r = r.parent
        }
        const f = t.appContext.config.errorHandler;
        if (f) {
            Me(f, null, 10, [e, o, c]);
            return
        }
    }
    fr(e, s, i, n)
}

function fr(e, t, s, n = !0) {
    console.error(e)
}
let _t = !1,
    gs = !1;
const Q = [];
let ye = 0;
const Ze = [];
let we = null,
    Be = 0;
const $n = Promise.resolve();
let Rs = null;

function ur(e) {
    const t = Rs || $n;
    return e ? t.then(this ? e.bind(this) : e) : t
}

function dr(e) {
    let t = ye + 1,
        s = Q.length;
    for (; t < s;) {
        const n = t + s >>> 1,
            i = Q[n],
            r = bt(i);
        r < e || r === e && i.pre ? t = n + 1 : s = n
    }
    return t
}

function Fs(e) {
    (!Q.length || !Q.includes(e, _t && e.allowRecurse ? ye + 1 : ye)) && (e.id == null ? Q.push(e) : Q.splice(dr(e.id), 0, e), Qn())
}

function Qn() {
    !_t && !gs && (gs = !0, Rs = $n.then(Xn))
}

function hr(e) {
    const t = Q.indexOf(e);
    t > ye && Q.splice(t, 1)
}

function pr(e) {
    O(e) ? Ze.push(...e) : (!we || !we.includes(e, e.allowRecurse ? Be + 1 : Be)) && Ze.push(e), Qn()
}

function tn(e, t = _t ? ye + 1 : 0) {
    for (; t < Q.length; t++) {
        const s = Q[t];
        s && s.pre && (Q.splice(t, 1), t--, s())
    }
}

function Vn(e) {
    if (Ze.length) {
        const t = [...new Set(Ze)];
        if (Ze.length = 0, we) {
            we.push(...t);
            return
        }
        for (we = t, we.sort((s, n) => bt(s) - bt(n)), Be = 0; Be < we.length; Be++) we[Be]();
        we = null, Be = 0
    }
}
const bt = e => e.id == null ? 1 / 0 : e.id,
    gr = (e, t) => {
        const s = bt(e) - bt(t);
        if (s === 0) {
            if (e.pre && !t.pre) return -1;
            if (t.pre && !e.pre) return 1
        }
        return s
    };

function Xn(e) {
    gs = !1, _t = !0, Q.sort(gr);
    const t = de;
    try {
        for (ye = 0; ye < Q.length; ye++) {
            const s = Q[ye];
            s && s.active !== !1 && Me(s, null, 14)
        }
    } finally {
        ye = 0, Q.length = 0, Vn(), _t = !1, Rs = null, (Q.length || Ze.length) && Xn()
    }
}

function mr(e, t, ...s) {
    if (e.isUnmounted) return;
    const n = e.vnode.props || j;
    let i = s;
    const r = t.startsWith("update:"),
        o = r && t.slice(7);
    if (o && o in n) {
        const m = `${o === "modelValue" ? "model" : o}Modifiers`,
            {
                number: x,
                trim: w
            } = n[m] || j;
        w && (i = s.map(I => q(I) ? I.trim() : I)), x && (i = s.map(Ti))
    }
    let c, f = n[c = ns(t)] || n[c = ns(Ge(t))];
    !f && r && (f = n[c = ns(nt(t))]), f && he(f, e, 6, i);
    const u = n[c + "Once"];
    if (u) {
        if (!e.emitted) e.emitted = {};
        else if (e.emitted[c]) return;
        e.emitted[c] = !0, he(u, e, 6, i)
    }
}

function Zn(e, t, s = !1) {
    const n = t.emitsCache,
        i = n.get(e);
    if (i !== void 0) return i;
    const r = e.emits;
    let o = {},
        c = !1;
    if (!A(e)) {
        const f = u => {
            const m = Zn(u, t, !0);
            m && (c = !0, Z(o, m))
        };
        !s && t.mixins.length && t.mixins.forEach(f), e.extends && f(e.extends), e.mixins && e.mixins.forEach(f)
    }
    return !r && !c ? (H(e) && n.set(e, null), null) : (O(r) ? r.forEach(f => o[f] = null) : Z(o, r), H(e) && n.set(e, o), o)
}

function Qt(e, t) {
    return !e || !Ut(t) ? !1 : (t = t.slice(2).replace(/Once$/, ""), R(e, t[0].toLowerCase() + t.slice(1)) || R(e, nt(t)) || R(e, t))
}
let ve = null,
    Gn = null;

function jt(e) {
    const t = ve;
    return ve = e, Gn = e && e.type.__scopeId || null, t
}

function _r(e, t = ve, s) {
    if (!t || e._n) return e;
    const n = (...i) => {
        n._d && dn(-1);
        const r = jt(t);
        let o;
        try {
            o = e(...i)
        } finally {
            jt(r), n._d && dn(1)
        }
        return o
    };
    return n._n = !0, n._c = !0, n._d = !0, n
}

function rs(e) {
    const {
        type: t,
        vnode: s,
        proxy: n,
        withProxy: i,
        props: r,
        propsOptions: [o],
        slots: c,
        attrs: f,
        emit: u,
        render: m,
        renderCache: x,
        data: w,
        setupState: I,
        ctx: U,
        inheritAttrs: D
    } = e;
    let z, Y;
    const J = jt(e);
    try {
        if (s.shapeFlag & 4) {
            const M = i || n,
                pe = M;
            z = be(m.call(pe, M, x, r, I, w, U)), Y = f
        } else {
            const M = t;
            z = be(M.length > 1 ? M(r, {
                attrs: f,
                slots: c,
                emit: u
            }) : M(r, null)), Y = t.props ? f : br(f)
        }
    } catch (M) {
        pt.length = 0, $t(M, e, 1), z = xe(We)
    }
    let $ = z;
    if (Y && D !== !1) {
        const M = Object.keys(Y),
            {
                shapeFlag: pe
            } = $;
        M.length && pe & 7 && (o && M.some(ws) && (Y = yr(Y, o)), $ = tt($, Y))
    }
    return s.dirs && ($ = tt($), $.dirs = $.dirs ? $.dirs.concat(s.dirs) : s.dirs), s.transition && ($.transition = s.transition), z = $, jt(J), z
}
const br = e => {
    let t;
    for (const s in e) (s === "class" || s === "style" || Ut(s)) && ((t || (t = {}))[s] = e[s]);
    return t
},
    yr = (e, t) => {
        const s = {};
        for (const n in e) (!ws(n) || !(n.slice(9) in t)) && (s[n] = e[n]);
        return s
    };

function vr(e, t, s) {
    const {
        props: n,
        children: i,
        component: r
    } = e, {
        props: o,
        children: c,
        patchFlag: f
    } = t, u = r.emitsOptions;
    if (t.dirs || t.transition) return !0;
    if (s && f >= 0) {
        if (f & 1024) return !0;
        if (f & 16) return n ? sn(n, o, u) : !!o;
        if (f & 8) {
            const m = t.dynamicProps;
            for (let x = 0; x < m.length; x++) {
                const w = m[x];
                if (o[w] !== n[w] && !Qt(u, w)) return !0
            }
        }
    } else return (i || c) && (!c || !c.$stable) ? !0 : n === o ? !1 : n ? o ? sn(n, o, u) : !0 : !!o;
    return !1
}

function sn(e, t, s) {
    const n = Object.keys(t);
    if (n.length !== Object.keys(e).length) return !0;
    for (let i = 0; i < n.length; i++) {
        const r = n[i];
        if (t[r] !== e[r] && !Qt(s, r)) return !0
    }
    return !1
}

function xr({
    vnode: e,
    parent: t
}, s) {
    for (; t && t.subTree === e;)(e = t.vnode).el = s, t = t.parent
}
const Cr = Symbol.for("v-ndc"),
    wr = e => e.__isSuspense;

function Er(e, t) {
    t && t.pendingBranch ? O(e) ? t.effects.push(...e) : t.effects.push(e) : pr(e)
}
const At = {};

function os(e, t, s) {
    return ei(e, t, s)
}

function ei(e, t, {
    immediate: s,
    deep: n,
    flush: i,
    onTrack: r,
    onTrigger: o
} = j) {
    var c;
    const f = Fi() === ((c = V) == null ? void 0 : c.scope) ? V : null;
    let u, m = !1,
        x = !1;
    if (X(e) ? (u = () => e.value, m = Bt(e)) : Xe(e) ? (u = () => e, n = !0) : O(e) ? (x = !0, m = e.some(M => Xe(M) || Bt(M)), u = () => e.map(M => {
        if (X(M)) return M.value;
        if (Xe(M)) return $e(M);
        if (A(M)) return Me(M, f, 2)
    })) : A(e) ? t ? u = () => Me(e, f, 2) : u = () => {
        if (!(f && f.isUnmounted)) return w && w(), he(e, f, 3, [I])
    } : u = de, t && n) {
        const M = u;
        u = () => $e(M())
    }
    let w, I = M => {
        w = J.onStop = () => {
            Me(M, f, 4), w = J.onStop = void 0
        }
    },
        U;
    if (vt)
        if (I = de, t ? s && he(t, f, 3, [u(), x ? [] : void 0, I]) : u(), i === "sync") {
            const M = xo();
            U = M.__watcherHandles || (M.__watcherHandles = [])
        } else return de;
    let D = x ? new Array(e.length).fill(At) : At;
    const z = () => {
        if (J.active)
            if (t) {
                const M = J.run();
                (n || m || (x ? M.some((pe, qe) => Ue(pe, D[qe])) : Ue(M, D))) && (w && w(), he(t, f, 3, [M, D === At ? void 0 : x && D[0] === At ? [] : D, I]), D = M)
            } else J.run()
    };
    z.allowRecurse = !!t;
    let Y;
    i === "sync" ? Y = z : i === "post" ? Y = () => ne(z, f && f.suspense) : (z.pre = !0, f && (z.id = f.uid), Y = () => Fs(z));
    const J = new Os(u, Y);
    t ? s ? z() : D = J.run() : i === "post" ? ne(J.run.bind(J), f && f.suspense) : J.run();
    const $ = () => {
        J.stop(), f && f.scope && Es(f.scope.effects, J)
    };
    return U && U.push($), $
}

function Sr(e, t, s) {
    const n = this.proxy,
        i = q(e) ? e.includes(".") ? ti(n, e) : () => n[e] : e.bind(n, n);
    let r;
    A(t) ? r = t : (r = t.handler, s = t);
    const o = V;
    st(this);
    const c = ei(i, r.bind(n), s);
    return o ? st(o) : Ke(), c
}

function ti(e, t) {
    const s = t.split(".");
    return () => {
        let n = e;
        for (let i = 0; i < s.length && n; i++) n = n[s[i]];
        return n
    }
}

function $e(e, t) {
    if (!H(e) || e.__v_skip || (t = t || new Set, t.has(e))) return e;
    if (t.add(e), X(e)) $e(e.value, t);
    else if (O(e))
        for (let s = 0; s < e.length; s++) $e(e[s], t);
    else if (Sn(e) || Ve(e)) e.forEach(s => {
        $e(s, t)
    });
    else if (Pn(e))
        for (const s in e) $e(e[s], t);
    return e
}

function ke(e, t, s, n) {
    const i = e.dirs,
        r = t && t.dirs;
    for (let o = 0; o < i.length; o++) {
        const c = i[o];
        r && (c.oldValue = r[o].value);
        let f = c.dir[n];
        f && (it(), he(f, s, 8, [e.el, c, e, t]), rt())
    }
}
const Dt = e => !!e.type.__asyncLoader,
    si = e => e.type.__isKeepAlive;

function Tr(e, t) {
    ni(e, "a", t)
}

function Or(e, t) {
    ni(e, "da", t)
}

function ni(e, t, s = V) {
    const n = e.__wdc || (e.__wdc = () => {
        let i = s;
        for (; i;) {
            if (i.isDeactivated) return;
            i = i.parent
        }
        return e()
    });
    if (Vt(t, n, s), s) {
        let i = s.parent;
        for (; i && i.parent;) si(i.parent.vnode) && Pr(n, t, s, i), i = i.parent
    }
}

function Pr(e, t, s, n) {
    const i = Vt(t, e, n, !0);
    ii(() => {
        Es(n[t], i)
    }, s)
}

function Vt(e, t, s = V, n = !1) {
    if (s) {
        const i = s[e] || (s[e] = []),
            r = t.__weh || (t.__weh = (...o) => {
                if (s.isUnmounted) return;
                it(), st(s);
                const c = he(t, s, e, o);
                return Ke(), rt(), c
            });
        return n ? i.unshift(r) : i.push(r), r
    }
}
const Te = e => (t, s = V) => (!vt || e === "sp") && Vt(e, (...n) => t(...n), s),
    Ir = Te("bm"),
    Ar = Te("m"),
    Mr = Te("bu"),
    Lr = Te("u"),
    Dr = Te("bum"),
    ii = Te("um"),
    Rr = Te("sp"),
    Fr = Te("rtg"),
    kr = Te("rtc");

function Nr(e, t = V) {
    Vt("ec", e, t)
}

function Mt(e, t, s, n) {
    let i;
    const r = s && s[n];
    if (O(e) || q(e)) {
        i = new Array(e.length);
        for (let o = 0, c = e.length; o < c; o++) i[o] = t(e[o], o, void 0, r && r[o])
    } else if (typeof e == "number") {
        i = new Array(e);
        for (let o = 0; o < e; o++) i[o] = t(o + 1, o, void 0, r && r[o])
    } else if (H(e))
        if (e[Symbol.iterator]) i = Array.from(e, (o, c) => t(o, c, void 0, r && r[c]));
        else {
            const o = Object.keys(e);
            i = new Array(o.length);
            for (let c = 0, f = o.length; c < f; c++) {
                const u = o[c];
                i[c] = t(e[u], u, c, r && r[c])
            }
        }
    else i = [];
    return s && (s[n] = i), i
}
const ms = e => e ? gi(e) ? Hs(e) || e.proxy : ms(e.parent) : null,
    ht = Z(Object.create(null), {
        $: e => e,
        $el: e => e.vnode.el,
        $data: e => e.data,
        $props: e => e.props,
        $attrs: e => e.attrs,
        $slots: e => e.slots,
        $refs: e => e.refs,
        $parent: e => ms(e.parent),
        $root: e => ms(e.root),
        $emit: e => e.emit,
        $options: e => ks(e),
        $forceUpdate: e => e.f || (e.f = () => Fs(e.update)),
        $nextTick: e => e.n || (e.n = ur.bind(e.proxy)),
        $watch: e => Sr.bind(e)
    }),
    ls = (e, t) => e !== j && !e.__isScriptSetup && R(e, t),
    Br = {
        get({
            _: e
        }, t) {
            const {
                ctx: s,
                setupState: n,
                data: i,
                props: r,
                accessCache: o,
                type: c,
                appContext: f
            } = e;
            let u;
            if (t[0] !== "$") {
                const I = o[t];
                if (I !== void 0) switch (I) {
                    case 1:
                        return n[t];
                    case 2:
                        return i[t];
                    case 4:
                        return s[t];
                    case 3:
                        return r[t]
                } else {
                    if (ls(n, t)) return o[t] = 1, n[t];
                    if (i !== j && R(i, t)) return o[t] = 2, i[t];
                    if ((u = e.propsOptions[0]) && R(u, t)) return o[t] = 3, r[t];
                    if (s !== j && R(s, t)) return o[t] = 4, s[t];
                    _s && (o[t] = 0)
                }
            }
            const m = ht[t];
            let x, w;
            if (m) return t === "$attrs" && re(e, "get", t), m(e);
            if ((x = c.__cssModules) && (x = x[t])) return x;
            if (s !== j && R(s, t)) return o[t] = 4, s[t];
            if (w = f.config.globalProperties, R(w, t)) return w[t]
        },
        set({
            _: e
        }, t, s) {
            const {
                data: n,
                setupState: i,
                ctx: r
            } = e;
            return ls(i, t) ? (i[t] = s, !0) : n !== j && R(n, t) ? (n[t] = s, !0) : R(e.props, t) || t[0] === "$" && t.slice(1) in e ? !1 : (r[t] = s, !0)
        },
        has({
            _: {
                data: e,
                setupState: t,
                accessCache: s,
                ctx: n,
                appContext: i,
                propsOptions: r
            }
        }, o) {
            let c;
            return !!s[o] || e !== j && R(e, o) || ls(t, o) || (c = r[0]) && R(c, o) || R(n, o) || R(ht, o) || R(i.config.globalProperties, o)
        },
        defineProperty(e, t, s) {
            return s.get != null ? e._.accessCache[t] = 0 : R(s, "value") && this.set(e, t, s.value, null), Reflect.defineProperty(e, t, s)
        }
    };

function nn(e) {
    return O(e) ? e.reduce((t, s) => (t[s] = null, t), {}) : e
}
let _s = !0;

function jr(e) {
    const t = ks(e),
        s = e.proxy,
        n = e.ctx;
    _s = !1, t.beforeCreate && rn(t.beforeCreate, e, "bc");
    const {
        data: i,
        computed: r,
        methods: o,
        watch: c,
        provide: f,
        inject: u,
        created: m,
        beforeMount: x,
        mounted: w,
        beforeUpdate: I,
        updated: U,
        activated: D,
        deactivated: z,
        beforeDestroy: Y,
        beforeUnmount: J,
        destroyed: $,
        unmounted: M,
        render: pe,
        renderTracked: qe,
        renderTriggered: ot,
        errorCaptured: Oe,
        serverPrefetch: Gt,
        expose: De,
        inheritAttrs: lt,
        components: xt,
        directives: Ct,
        filters: es
    } = t;
    if (u && Hr(u, n, null), o)
        for (const K in o) {
            const N = o[K];
            A(N) && (n[K] = N.bind(s))
        }
    if (i) {
        const K = i.call(s, s);
        H(K) && (e.data = As(K))
    }
    if (_s = !0, r)
        for (const K in r) {
            const N = r[K],
                Re = A(N) ? N.bind(s, s) : A(N.get) ? N.get.bind(s, s) : de,
                wt = !A(N) && A(N.set) ? N.set.bind(s) : de,
                Fe = yo({
                    get: Re,
                    set: wt
                });
            Object.defineProperty(n, K, {
                enumerable: !0,
                configurable: !0,
                get: () => Fe.value,
                set: ge => Fe.value = ge
            })
        }
    if (c)
        for (const K in c) ri(c[K], n, s, K);
    if (f) {
        const K = A(f) ? f.call(s) : f;
        Reflect.ownKeys(K).forEach(N => {
            Jr(N, K[N])
        })
    }
    m && rn(m, e, "c");

    function G(K, N) {
        O(N) ? N.forEach(Re => K(Re.bind(s))) : N && K(N.bind(s))
    }
    if (G(Ir, x), G(Ar, w), G(Mr, I), G(Lr, U), G(Tr, D), G(Or, z), G(Nr, Oe), G(kr, qe), G(Fr, ot), G(Dr, J), G(ii, M), G(Rr, Gt), O(De))
        if (De.length) {
            const K = e.exposed || (e.exposed = {});
            De.forEach(N => {
                Object.defineProperty(K, N, {
                    get: () => s[N],
                    set: Re => s[N] = Re
                })
            })
        } else e.exposed || (e.exposed = {});
    pe && e.render === de && (e.render = pe), lt != null && (e.inheritAttrs = lt), xt && (e.components = xt), Ct && (e.directives = Ct)
}

function Hr(e, t, s = de) {
    O(e) && (e = bs(e));
    for (const n in e) {
        const i = e[n];
        let r;
        H(i) ? "default" in i ? r = Rt(i.from || n, i.default, !0) : r = Rt(i.from || n) : r = Rt(i), X(r) ? Object.defineProperty(t, n, {
            enumerable: !0,
            configurable: !0,
            get: () => r.value,
            set: o => r.value = o
        }) : t[n] = r
    }
}

function rn(e, t, s) {
    he(O(e) ? e.map(n => n.bind(t.proxy)) : e.bind(t.proxy), t, s)
}

function ri(e, t, s, n) {
    const i = n.includes(".") ? ti(s, n) : () => s[n];
    if (q(e)) {
        const r = t[e];
        A(r) && os(i, r)
    } else if (A(e)) os(i, e.bind(s));
    else if (H(e))
        if (O(e)) e.forEach(r => ri(r, t, s, n));
        else {
            const r = A(e.handler) ? e.handler.bind(s) : t[e.handler];
            A(r) && os(i, r, e)
        }
}

function ks(e) {
    const t = e.type,
        {
            mixins: s,
            extends: n
        } = t,
        {
            mixins: i,
            optionsCache: r,
            config: {
                optionMergeStrategies: o
            }
        } = e.appContext,
        c = r.get(t);
    let f;
    return c ? f = c : !i.length && !s && !n ? f = t : (f = {}, i.length && i.forEach(u => Ht(f, u, o, !0)), Ht(f, t, o)), H(t) && r.set(t, f), f
}

function Ht(e, t, s, n = !1) {
    const {
        mixins: i,
        extends: r
    } = t;
    r && Ht(e, r, s, !0), i && i.forEach(o => Ht(e, o, s, !0));
    for (const o in t)
        if (!(n && o === "expose")) {
            const c = Kr[o] || s && s[o];
            e[o] = c ? c(e[o], t[o]) : t[o]
        } return e
}
const Kr = {
    data: on,
    props: ln,
    emits: ln,
    methods: dt,
    computed: dt,
    beforeCreate: ee,
    created: ee,
    beforeMount: ee,
    mounted: ee,
    beforeUpdate: ee,
    updated: ee,
    beforeDestroy: ee,
    beforeUnmount: ee,
    destroyed: ee,
    unmounted: ee,
    activated: ee,
    deactivated: ee,
    errorCaptured: ee,
    serverPrefetch: ee,
    components: dt,
    directives: dt,
    watch: Wr,
    provide: on,
    inject: Ur
};

function on(e, t) {
    return t ? e ? function () {
        return Z(A(e) ? e.call(this, this) : e, A(t) ? t.call(this, this) : t)
    } : t : e
}

function Ur(e, t) {
    return dt(bs(e), bs(t))
}

function bs(e) {
    if (O(e)) {
        const t = {};
        for (let s = 0; s < e.length; s++) t[e[s]] = e[s];
        return t
    }
    return e
}

function ee(e, t) {
    return e ? [...new Set([].concat(e, t))] : t
}

function dt(e, t) {
    return e ? Z(Object.create(null), e, t) : t
}

function ln(e, t) {
    return e ? O(e) && O(t) ? [...new Set([...e, ...t])] : Z(Object.create(null), nn(e), nn(t ?? {})) : t
}

function Wr(e, t) {
    if (!e) return t;
    if (!t) return e;
    const s = Z(Object.create(null), e);
    for (const n in t) s[n] = ee(e[n], t[n]);
    return s
}

function oi() {
    return {
        app: null,
        config: {
            isNativeTag: vi,
            performance: !1,
            globalProperties: {},
            optionMergeStrategies: {},
            errorHandler: void 0,
            warnHandler: void 0,
            compilerOptions: {}
        },
        mixins: [],
        components: {},
        directives: {},
        provides: Object.create(null),
        optionsCache: new WeakMap,
        propsCache: new WeakMap,
        emitsCache: new WeakMap
    }
}
let qr = 0;

function zr(e, t) {
    return function (n, i = null) {
        A(n) || (n = Z({}, n)), i != null && !H(i) && (i = null);
        const r = oi(),
            o = new WeakSet;
        let c = !1;
        const f = r.app = {
            _uid: qr++,
            _component: n,
            _props: i,
            _container: null,
            _context: r,
            _instance: null,
            version: Co,
            get config() {
                return r.config
            },
            set config(u) { },
            use(u, ...m) {
                return o.has(u) || (u && A(u.install) ? (o.add(u), u.install(f, ...m)) : A(u) && (o.add(u), u(f, ...m))), f
            },
            mixin(u) {
                return r.mixins.includes(u) || r.mixins.push(u), f
            },
            component(u, m) {
                return m ? (r.components[u] = m, f) : r.components[u]
            },
            directive(u, m) {
                return m ? (r.directives[u] = m, f) : r.directives[u]
            },
            mount(u, m, x) {
                if (!c) {
                    const w = xe(n, i);
                    return w.appContext = r, m && t ? t(w, u) : e(w, u, x), c = !0, f._container = u, u.__vue_app__ = f, Hs(w.component) || w.component.proxy
                }
            },
            unmount() {
                c && (e(null, f._container), delete f._container.__vue_app__)
            },
            provide(u, m) {
                return r.provides[u] = m, f
            },
            runWithContext(u) {
                Kt = f;
                try {
                    return u()
                } finally {
                    Kt = null
                }
            }
        };
        return f
    }
}
let Kt = null;

function Jr(e, t) {
    if (V) {
        let s = V.provides;
        const n = V.parent && V.parent.provides;
        n === s && (s = V.provides = Object.create(n)), s[e] = t
    }
}

function Rt(e, t, s = !1) {
    const n = V || ve;
    if (n || Kt) {
        const i = n ? n.parent == null ? n.vnode.appContext && n.vnode.appContext.provides : n.parent.provides : Kt._context.provides;
        if (i && e in i) return i[e];
        if (arguments.length > 1) return s && A(t) ? t.call(n && n.proxy) : t
    }
}

function Yr(e, t, s, n = !1) {
    const i = {},
        r = {};
    Nt(r, Zt, 1), e.propsDefaults = Object.create(null), li(e, t, i, r);
    for (const o in e.propsOptions[0]) o in i || (i[o] = void 0);
    s ? e.props = n ? i : sr(i) : e.type.props ? e.props = i : e.props = r, e.attrs = r
}

function $r(e, t, s, n) {
    const {
        props: i,
        attrs: r,
        vnode: {
            patchFlag: o
        }
    } = e, c = F(i), [f] = e.propsOptions;
    let u = !1;
    if ((n || o > 0) && !(o & 16)) {
        if (o & 8) {
            const m = e.vnode.dynamicProps;
            for (let x = 0; x < m.length; x++) {
                let w = m[x];
                if (Qt(e.emitsOptions, w)) continue;
                const I = t[w];
                if (f)
                    if (R(r, w)) I !== r[w] && (r[w] = I, u = !0);
                    else {
                        const U = Ge(w);
                        i[U] = ys(f, c, U, I, e, !1)
                    }
                else I !== r[w] && (r[w] = I, u = !0)
            }
        }
    } else {
        li(e, t, i, r) && (u = !0);
        let m;
        for (const x in c) (!t || !R(t, x) && ((m = nt(x)) === x || !R(t, m))) && (f ? s && (s[x] !== void 0 || s[m] !== void 0) && (i[x] = ys(f, c, x, void 0, e, !0)) : delete i[x]);
        if (r !== c)
            for (const x in r) (!t || !R(t, x)) && (delete r[x], u = !0)
    }
    u && Se(e, "set", "$attrs")
}

function li(e, t, s, n) {
    const [i, r] = e.propsOptions;
    let o = !1,
        c;
    if (t)
        for (let f in t) {
            if (Lt(f)) continue;
            const u = t[f];
            let m;
            i && R(i, m = Ge(f)) ? !r || !r.includes(m) ? s[m] = u : (c || (c = {}))[m] = u : Qt(e.emitsOptions, f) || (!(f in n) || u !== n[f]) && (n[f] = u, o = !0)
        }
    if (r) {
        const f = F(s),
            u = c || j;
        for (let m = 0; m < r.length; m++) {
            const x = r[m];
            s[x] = ys(i, f, x, u[x], e, !R(u, x))
        }
    }
    return o
}

function ys(e, t, s, n, i, r) {
    const o = e[s];
    if (o != null) {
        const c = R(o, "default");
        if (c && n === void 0) {
            const f = o.default;
            if (o.type !== Function && !o.skipFactory && A(f)) {
                const {
                    propsDefaults: u
                } = i;
                s in u ? n = u[s] : (st(i), n = u[s] = f.call(null, t), Ke())
            } else n = f
        }
        o[0] && (r && !c ? n = !1 : o[1] && (n === "" || n === nt(s)) && (n = !0))
    }
    return n
}

function ci(e, t, s = !1) {
    const n = t.propsCache,
        i = n.get(e);
    if (i) return i;
    const r = e.props,
        o = {},
        c = [];
    let f = !1;
    if (!A(e)) {
        const m = x => {
            f = !0;
            const [w, I] = ci(x, t, !0);
            Z(o, w), I && c.push(...I)
        };
        !s && t.mixins.length && t.mixins.forEach(m), e.extends && m(e.extends), e.mixins && e.mixins.forEach(m)
    }
    if (!r && !f) return H(e) && n.set(e, Qe), Qe;
    if (O(r))
        for (let m = 0; m < r.length; m++) {
            const x = Ge(r[m]);
            cn(x) && (o[x] = j)
        } else if (r)
        for (const m in r) {
            const x = Ge(m);
            if (cn(x)) {
                const w = r[m],
                    I = o[x] = O(w) || A(w) ? {
                        type: w
                    } : Z({}, w);
                if (I) {
                    const U = un(Boolean, I.type),
                        D = un(String, I.type);
                    I[0] = U > -1, I[1] = D < 0 || U < D, (U > -1 || R(I, "default")) && c.push(x)
                }
            }
        }
    const u = [o, c];
    return H(e) && n.set(e, u), u
}

function cn(e) {
    return e[0] !== "$"
}

function an(e) {
    const t = e && e.toString().match(/^\s*(function|class) (\w+)/);
    return t ? t[2] : e === null ? "null" : ""
}

function fn(e, t) {
    return an(e) === an(t)
}

function un(e, t) {
    return O(t) ? t.findIndex(s => fn(s, e)) : A(t) && fn(t, e) ? 0 : -1
}
const ai = e => e[0] === "_" || e === "$stable",
    Ns = e => O(e) ? e.map(be) : [be(e)],
    Qr = (e, t, s) => {
        if (t._n) return t;
        const n = _r((...i) => Ns(t(...i)), s);
        return n._c = !1, n
    },
    fi = (e, t, s) => {
        const n = e._ctx;
        for (const i in e) {
            if (ai(i)) continue;
            const r = e[i];
            if (A(r)) t[i] = Qr(i, r, n);
            else if (r != null) {
                const o = Ns(r);
                t[i] = () => o
            }
        }
    },
    ui = (e, t) => {
        const s = Ns(t);
        e.slots.default = () => s
    },
    Vr = (e, t) => {
        if (e.vnode.shapeFlag & 32) {
            const s = t._;
            s ? (e.slots = F(t), Nt(t, "_", s)) : fi(t, e.slots = {})
        } else e.slots = {}, t && ui(e, t);
        Nt(e.slots, Zt, 1)
    },
    Xr = (e, t, s) => {
        const {
            vnode: n,
            slots: i
        } = e;
        let r = !0,
            o = j;
        if (n.shapeFlag & 32) {
            const c = t._;
            c ? s && c === 1 ? r = !1 : (Z(i, t), !s && c === 1 && delete i._) : (r = !t.$stable, fi(t, i)), o = t
        } else t && (ui(e, t), o = {
            default: 1
        });
        if (r)
            for (const c in i) !ai(c) && o[c] == null && delete i[c]
    };

function vs(e, t, s, n, i = !1) {
    if (O(e)) {
        e.forEach((w, I) => vs(w, t && (O(t) ? t[I] : t), s, n, i));
        return
    }
    if (Dt(n) && !i) return;
    const r = n.shapeFlag & 4 ? Hs(n.component) || n.component.proxy : n.el,
        o = i ? null : r,
        {
            i: c,
            r: f
        } = e,
        u = t && t.r,
        m = c.refs === j ? c.refs = {} : c.refs,
        x = c.setupState;
    if (u != null && u !== f && (q(u) ? (m[u] = null, R(x, u) && (x[u] = null)) : X(u) && (u.value = null)), A(f)) Me(f, c, 12, [o, m]);
    else {
        const w = q(f),
            I = X(f);
        if (w || I) {
            const U = () => {
                if (e.f) {
                    const D = w ? R(x, f) ? x[f] : m[f] : f.value;
                    i ? O(D) && Es(D, r) : O(D) ? D.includes(r) || D.push(r) : w ? (m[f] = [r], R(x, f) && (x[f] = m[f])) : (f.value = [r], e.k && (m[e.k] = f.value))
                } else w ? (m[f] = o, R(x, f) && (x[f] = o)) : I && (f.value = o, e.k && (m[e.k] = o))
            };
            o ? (U.id = -1, ne(U, s)) : U()
        }
    }
}
const ne = Er;

function Zr(e) {
    return Gr(e)
}

function Gr(e, t) {
    const s = fs();
    s.__VUE__ = !0;
    const {
        insert: n,
        remove: i,
        patchProp: r,
        createElement: o,
        createText: c,
        createComment: f,
        setText: u,
        setElementText: m,
        parentNode: x,
        nextSibling: w,
        setScopeId: I = de,
        insertStaticContent: U
    } = e, D = (l, a, d, h = null, p = null, b = null, v = !1, _ = null, y = !!a.dynamicChildren) => {
        if (l === a) return;
        l && !at(l, a) && (h = Et(l), ge(l, p, b, !0), l = null), a.patchFlag === -2 && (y = !1, a.dynamicChildren = null);
        const {
            type: g,
            ref: S,
            shapeFlag: C
        } = a;
        switch (g) {
            case Xt:
                z(l, a, d, h);
                break;
            case We:
                Y(l, a, d, h);
                break;
            case Ft:
                l == null && J(a, d, h, v);
                break;
            case ie:
                xt(l, a, d, h, p, b, v, _, y);
                break;
            default:
                C & 1 ? pe(l, a, d, h, p, b, v, _, y) : C & 6 ? Ct(l, a, d, h, p, b, v, _, y) : (C & 64 || C & 128) && g.process(l, a, d, h, p, b, v, _, y, ze)
        }
        S != null && p && vs(S, l && l.ref, b, a || l, !a)
    }, z = (l, a, d, h) => {
        if (l == null) n(a.el = c(a.children), d, h);
        else {
            const p = a.el = l.el;
            a.children !== l.children && u(p, a.children)
        }
    }, Y = (l, a, d, h) => {
        l == null ? n(a.el = f(a.children || ""), d, h) : a.el = l.el
    }, J = (l, a, d, h) => {
        [l.el, l.anchor] = U(l.children, a, d, h, l.el, l.anchor)
    }, $ = ({
        el: l,
        anchor: a
    }, d, h) => {
        let p;
        for (; l && l !== a;) p = w(l), n(l, d, h), l = p;
        n(a, d, h)
    }, M = ({
        el: l,
        anchor: a
    }) => {
        let d;
        for (; l && l !== a;) d = w(l), i(l), l = d;
        i(a)
    }, pe = (l, a, d, h, p, b, v, _, y) => {
        v = v || a.type === "svg", l == null ? qe(a, d, h, p, b, v, _, y) : Gt(l, a, p, b, v, _, y)
    }, qe = (l, a, d, h, p, b, v, _) => {
        let y, g;
        const {
            type: S,
            props: C,
            shapeFlag: T,
            transition: P,
            dirs: L
        } = l;
        if (y = l.el = o(l.type, b, C && C.is, C), T & 8 ? m(y, l.children) : T & 16 && Oe(l.children, y, null, h, p, b && S !== "foreignObject", v, _), L && ke(l, null, h, "created"), ot(y, l, l.scopeId, v, h), C) {
            for (const k in C) k !== "value" && !Lt(k) && r(y, k, null, C[k], b, l.children, h, p, Ce);
            "value" in C && r(y, "value", null, C.value), (g = C.onVnodeBeforeMount) && _e(g, h, l)
        }
        L && ke(l, null, h, "beforeMount");
        const B = eo(p, P);
        B && P.beforeEnter(y), n(y, a, d), ((g = C && C.onVnodeMounted) || B || L) && ne(() => {
            g && _e(g, h, l), B && P.enter(y), L && ke(l, null, h, "mounted")
        }, p)
    }, ot = (l, a, d, h, p) => {
        if (d && I(l, d), h)
            for (let b = 0; b < h.length; b++) I(l, h[b]);
        if (p) {
            let b = p.subTree;
            if (a === b) {
                const v = p.vnode;
                ot(l, v, v.scopeId, v.slotScopeIds, p.parent)
            }
        }
    }, Oe = (l, a, d, h, p, b, v, _, y = 0) => {
        for (let g = y; g < l.length; g++) {
            const S = l[g] = _ ? Ie(l[g]) : be(l[g]);
            D(null, S, a, d, h, p, b, v, _)
        }
    }, Gt = (l, a, d, h, p, b, v) => {
        const _ = a.el = l.el;
        let {
            patchFlag: y,
            dynamicChildren: g,
            dirs: S
        } = a;
        y |= l.patchFlag & 16;
        const C = l.props || j,
            T = a.props || j;
        let P;
        d && Ne(d, !1), (P = T.onVnodeBeforeUpdate) && _e(P, d, a, l), S && ke(a, l, d, "beforeUpdate"), d && Ne(d, !0);
        const L = p && a.type !== "foreignObject";
        if (g ? De(l.dynamicChildren, g, _, d, h, L, b) : v || N(l, a, _, null, d, h, L, b, !1), y > 0) {
            if (y & 16) lt(_, a, C, T, d, h, p);
            else if (y & 2 && C.class !== T.class && r(_, "class", null, T.class, p), y & 4 && r(_, "style", C.style, T.style, p), y & 8) {
                const B = a.dynamicProps;
                for (let k = 0; k < B.length; k++) {
                    const W = B[k],
                        le = C[W],
                        Je = T[W];
                    (Je !== le || W === "value") && r(_, W, le, Je, p, l.children, d, h, Ce)
                }
            }
            y & 1 && l.children !== a.children && m(_, a.children)
        } else !v && g == null && lt(_, a, C, T, d, h, p);
        ((P = T.onVnodeUpdated) || S) && ne(() => {
            P && _e(P, d, a, l), S && ke(a, l, d, "updated")
        }, h)
    }, De = (l, a, d, h, p, b, v) => {
        for (let _ = 0; _ < a.length; _++) {
            const y = l[_],
                g = a[_],
                S = y.el && (y.type === ie || !at(y, g) || y.shapeFlag & 70) ? x(y.el) : d;
            D(y, g, S, null, h, p, b, v, !0)
        }
    }, lt = (l, a, d, h, p, b, v) => {
        if (d !== h) {
            if (d !== j)
                for (const _ in d) !Lt(_) && !(_ in h) && r(l, _, d[_], null, v, a.children, p, b, Ce);
            for (const _ in h) {
                if (Lt(_)) continue;
                const y = h[_],
                    g = d[_];
                y !== g && _ !== "value" && r(l, _, g, y, v, a.children, p, b, Ce)
            }
            "value" in h && r(l, "value", d.value, h.value)
        }
    }, xt = (l, a, d, h, p, b, v, _, y) => {
        const g = a.el = l ? l.el : c(""),
            S = a.anchor = l ? l.anchor : c("");
        let {
            patchFlag: C,
            dynamicChildren: T,
            slotScopeIds: P
        } = a;
        P && (_ = _ ? _.concat(P) : P), l == null ? (n(g, d, h), n(S, d, h), Oe(a.children, d, S, p, b, v, _, y)) : C > 0 && C & 64 && T && l.dynamicChildren ? (De(l.dynamicChildren, T, d, p, b, v, _), (a.key != null || p && a === p.subTree) && di(l, a, !0)) : N(l, a, d, S, p, b, v, _, y)
    }, Ct = (l, a, d, h, p, b, v, _, y) => {
        a.slotScopeIds = _, l == null ? a.shapeFlag & 512 ? p.ctx.activate(a, d, h, v, y) : es(a, d, h, p, b, v, y) : Ks(l, a, y)
    }, es = (l, a, d, h, p, b, v) => {
        const _ = l.component = ho(l, h, p);
        if (si(l) && (_.ctx.renderer = ze), po(_), _.asyncDep) {
            if (p && p.registerDep(_, G), !l.el) {
                const y = _.subTree = xe(We);
                Y(null, y, a, d)
            }
            return
        }
        G(_, l, a, d, p, b, v)
    }, Ks = (l, a, d) => {
        const h = a.component = l.component;
        if (vr(l, a, d))
            if (h.asyncDep && !h.asyncResolved) {
                K(h, a, d);
                return
            } else h.next = a, hr(h.update), h.update();
        else a.el = l.el, h.vnode = a
    }, G = (l, a, d, h, p, b, v) => {
        const _ = () => {
            if (l.isMounted) {
                let {
                    next: S,
                    bu: C,
                    u: T,
                    parent: P,
                    vnode: L
                } = l, B = S, k;
                Ne(l, !1), S ? (S.el = L.el, K(l, S, v)) : S = L, C && is(C), (k = S.props && S.props.onVnodeBeforeUpdate) && _e(k, P, S, L), Ne(l, !0);
                const W = rs(l),
                    le = l.subTree;
                l.subTree = W, D(le, W, x(le.el), Et(le), l, p, b), S.el = W.el, B === null && xr(l, W.el), T && ne(T, p), (k = S.props && S.props.onVnodeUpdated) && ne(() => _e(k, P, S, L), p)
            } else {
                let S;
                const {
                    el: C,
                    props: T
                } = a, {
                    bm: P,
                    m: L,
                    parent: B
                } = l, k = Dt(a);
                if (Ne(l, !1), P && is(P), !k && (S = T && T.onVnodeBeforeMount) && _e(S, B, a), Ne(l, !0), C && ss) {
                    const W = () => {
                        l.subTree = rs(l), ss(C, l.subTree, l, p, null)
                    };
                    k ? a.type.__asyncLoader().then(() => !l.isUnmounted && W()) : W()
                } else {
                    const W = l.subTree = rs(l);
                    D(null, W, d, h, l, p, b), a.el = W.el
                }
                if (L && ne(L, p), !k && (S = T && T.onVnodeMounted)) {
                    const W = a;
                    ne(() => _e(S, B, W), p)
                } (a.shapeFlag & 256 || B && Dt(B.vnode) && B.vnode.shapeFlag & 256) && l.a && ne(l.a, p), l.isMounted = !0, a = d = h = null
            }
        },
            y = l.effect = new Os(_, () => Fs(g), l.scope),
            g = l.update = () => y.run();
        g.id = l.uid, Ne(l, !0), g()
    }, K = (l, a, d) => {
        a.component = l;
        const h = l.vnode.props;
        l.vnode = a, l.next = null, $r(l, a.props, h, d), Xr(l, a.children, d), it(), tn(), rt()
    }, N = (l, a, d, h, p, b, v, _, y = !1) => {
        const g = l && l.children,
            S = l ? l.shapeFlag : 0,
            C = a.children,
            {
                patchFlag: T,
                shapeFlag: P
            } = a;
        if (T > 0) {
            if (T & 128) {
                wt(g, C, d, h, p, b, v, _, y);
                return
            } else if (T & 256) {
                Re(g, C, d, h, p, b, v, _, y);
                return
            }
        }
        P & 8 ? (S & 16 && Ce(g, p, b), C !== g && m(d, C)) : S & 16 ? P & 16 ? wt(g, C, d, h, p, b, v, _, y) : Ce(g, p, b, !0) : (S & 8 && m(d, ""), P & 16 && Oe(C, d, h, p, b, v, _, y))
    }, Re = (l, a, d, h, p, b, v, _, y) => {
        l = l || Qe, a = a || Qe;
        const g = l.length,
            S = a.length,
            C = Math.min(g, S);
        let T;
        for (T = 0; T < C; T++) {
            const P = a[T] = y ? Ie(a[T]) : be(a[T]);
            D(l[T], P, d, null, p, b, v, _, y)
        }
        g > S ? Ce(l, p, b, !0, !1, C) : Oe(a, d, h, p, b, v, _, y, C)
    }, wt = (l, a, d, h, p, b, v, _, y) => {
        let g = 0;
        const S = a.length;
        let C = l.length - 1,
            T = S - 1;
        for (; g <= C && g <= T;) {
            const P = l[g],
                L = a[g] = y ? Ie(a[g]) : be(a[g]);
            if (at(P, L)) D(P, L, d, null, p, b, v, _, y);
            else break;
            g++
        }
        for (; g <= C && g <= T;) {
            const P = l[C],
                L = a[T] = y ? Ie(a[T]) : be(a[T]);
            if (at(P, L)) D(P, L, d, null, p, b, v, _, y);
            else break;
            C--, T--
        }
        if (g > C) {
            if (g <= T) {
                const P = T + 1,
                    L = P < S ? a[P].el : h;
                for (; g <= T;) D(null, a[g] = y ? Ie(a[g]) : be(a[g]), d, L, p, b, v, _, y), g++
            }
        } else if (g > T)
            for (; g <= C;) ge(l[g], p, b, !0), g++;
        else {
            const P = g,
                L = g,
                B = new Map;
            for (g = L; g <= T; g++) {
                const oe = a[g] = y ? Ie(a[g]) : be(a[g]);
                oe.key != null && B.set(oe.key, g)
            }
            let k, W = 0;
            const le = T - L + 1;
            let Je = !1,
                qs = 0;
            const ct = new Array(le);
            for (g = 0; g < le; g++) ct[g] = 0;
            for (g = P; g <= C; g++) {
                const oe = l[g];
                if (W >= le) {
                    ge(oe, p, b, !0);
                    continue
                }
                let me;
                if (oe.key != null) me = B.get(oe.key);
                else
                    for (k = L; k <= T; k++)
                        if (ct[k - L] === 0 && at(oe, a[k])) {
                            me = k;
                            break
                        } me === void 0 ? ge(oe, p, b, !0) : (ct[me - L] = g + 1, me >= qs ? qs = me : Je = !0, D(oe, a[me], d, null, p, b, v, _, y), W++)
            }
            const zs = Je ? to(ct) : Qe;
            for (k = zs.length - 1, g = le - 1; g >= 0; g--) {
                const oe = L + g,
                    me = a[oe],
                    Js = oe + 1 < S ? a[oe + 1].el : h;
                ct[g] === 0 ? D(null, me, d, Js, p, b, v, _, y) : Je && (k < 0 || g !== zs[k] ? Fe(me, d, Js, 2) : k--)
            }
        }
    }, Fe = (l, a, d, h, p = null) => {
        const {
            el: b,
            type: v,
            transition: _,
            children: y,
            shapeFlag: g
        } = l;
        if (g & 6) {
            Fe(l.component.subTree, a, d, h);
            return
        }
        if (g & 128) {
            l.suspense.move(a, d, h);
            return
        }
        if (g & 64) {
            v.move(l, a, d, ze);
            return
        }
        if (v === ie) {
            n(b, a, d);
            for (let C = 0; C < y.length; C++) Fe(y[C], a, d, h);
            n(l.anchor, a, d);
            return
        }
        if (v === Ft) {
            $(l, a, d);
            return
        }
        if (h !== 2 && g & 1 && _)
            if (h === 0) _.beforeEnter(b), n(b, a, d), ne(() => _.enter(b), p);
            else {
                const {
                    leave: C,
                    delayLeave: T,
                    afterLeave: P
                } = _, L = () => n(b, a, d), B = () => {
                    C(b, () => {
                        L(), P && P()
                    })
                };
                T ? T(b, L, B) : B()
            }
        else n(b, a, d)
    }, ge = (l, a, d, h = !1, p = !1) => {
        const {
            type: b,
            props: v,
            ref: _,
            children: y,
            dynamicChildren: g,
            shapeFlag: S,
            patchFlag: C,
            dirs: T
        } = l;
        if (_ != null && vs(_, null, d, l, !0), S & 256) {
            a.ctx.deactivate(l);
            return
        }
        const P = S & 1 && T,
            L = !Dt(l);
        let B;
        if (L && (B = v && v.onVnodeBeforeUnmount) && _e(B, a, l), S & 6) yi(l.component, d, h);
        else {
            if (S & 128) {
                l.suspense.unmount(d, h);
                return
            }
            P && ke(l, null, a, "beforeUnmount"), S & 64 ? l.type.remove(l, a, d, p, ze, h) : g && (b !== ie || C > 0 && C & 64) ? Ce(g, a, d, !1, !0) : (b === ie && C & 384 || !p && S & 16) && Ce(y, a, d), h && Us(l)
        } (L && (B = v && v.onVnodeUnmounted) || P) && ne(() => {
            B && _e(B, a, l), P && ke(l, null, a, "unmounted")
        }, d)
    }, Us = l => {
        const {
            type: a,
            el: d,
            anchor: h,
            transition: p
        } = l;
        if (a === ie) {
            bi(d, h);
            return
        }
        if (a === Ft) {
            M(l);
            return
        }
        const b = () => {
            i(d), p && !p.persisted && p.afterLeave && p.afterLeave()
        };
        if (l.shapeFlag & 1 && p && !p.persisted) {
            const {
                leave: v,
                delayLeave: _
            } = p, y = () => v(d, b);
            _ ? _(l.el, b, y) : y()
        } else b()
    }, bi = (l, a) => {
        let d;
        for (; l !== a;) d = w(l), i(l), l = d;
        i(a)
    }, yi = (l, a, d) => {
        const {
            bum: h,
            scope: p,
            update: b,
            subTree: v,
            um: _
        } = l;
        h && is(h), p.stop(), b && (b.active = !1, ge(v, l, a, d)), _ && ne(_, a), ne(() => {
            l.isUnmounted = !0
        }, a), a && a.pendingBranch && !a.isUnmounted && l.asyncDep && !l.asyncResolved && l.suspenseId === a.pendingId && (a.deps--, a.deps === 0 && a.resolve())
    }, Ce = (l, a, d, h = !1, p = !1, b = 0) => {
        for (let v = b; v < l.length; v++) ge(l[v], a, d, h, p)
    }, Et = l => l.shapeFlag & 6 ? Et(l.component.subTree) : l.shapeFlag & 128 ? l.suspense.next() : w(l.anchor || l.el), Ws = (l, a, d) => {
        l == null ? a._vnode && ge(a._vnode, null, null, !0) : D(a._vnode || null, l, a, null, null, null, d), tn(), Vn(), a._vnode = l
    }, ze = {
        p: D,
        um: ge,
        m: Fe,
        r: Us,
        mt: es,
        mc: Oe,
        pc: N,
        pbc: De,
        n: Et,
        o: e
    };
    let ts, ss;
    return t && ([ts, ss] = t(ze)), {
        render: Ws,
        hydrate: ts,
        createApp: zr(Ws, ts)
    }
}

function Ne({
    effect: e,
    update: t
}, s) {
    e.allowRecurse = t.allowRecurse = s
}

function eo(e, t) {
    return (!e || e && !e.pendingBranch) && t && !t.persisted
}

function di(e, t, s = !1) {
    const n = e.children,
        i = t.children;
    if (O(n) && O(i))
        for (let r = 0; r < n.length; r++) {
            const o = n[r];
            let c = i[r];
            c.shapeFlag & 1 && !c.dynamicChildren && ((c.patchFlag <= 0 || c.patchFlag === 32) && (c = i[r] = Ie(i[r]), c.el = o.el), s || di(o, c)), c.type === Xt && (c.el = o.el)
        }
}

function to(e) {
    const t = e.slice(),
        s = [0];
    let n, i, r, o, c;
    const f = e.length;
    for (n = 0; n < f; n++) {
        const u = e[n];
        if (u !== 0) {
            if (i = s[s.length - 1], e[i] < u) {
                t[n] = i, s.push(n);
                continue
            }
            for (r = 0, o = s.length - 1; r < o;) c = r + o >> 1, e[s[c]] < u ? r = c + 1 : o = c;
            u < e[s[r]] && (r > 0 && (t[n] = s[r - 1]), s[r] = n)
        }
    }
    for (r = s.length, o = s[r - 1]; r-- > 0;) s[r] = o, o = t[o];
    return s
}
const so = e => e.__isTeleport,
    ie = Symbol.for("v-fgt"),
    Xt = Symbol.for("v-txt"),
    We = Symbol.for("v-cmt"),
    Ft = Symbol.for("v-stc"),
    pt = [];
let ue = null;

function te(e = !1) {
    pt.push(ue = e ? null : [])
}

function no() {
    pt.pop(), ue = pt[pt.length - 1] || null
}
let yt = 1;

function dn(e) {
    yt += e
}

function hi(e) {
    return e.dynamicChildren = yt > 0 ? ue || Qe : null, no(), yt > 0 && ue && ue.push(e), e
}

function se(e, t, s, n, i, r) {
    return hi(E(e, t, s, n, i, r, !0))
}

function io(e, t, s, n, i) {
    return hi(xe(e, t, s, n, i, !0))
}

function ro(e) {
    return e ? e.__v_isVNode === !0 : !1
}

function at(e, t) {
    return e.type === t.type && e.key === t.key
}
const Zt = "__vInternal",
    pi = ({
        key: e
    }) => e ?? null,
    kt = ({
        ref: e,
        ref_key: t,
        ref_for: s
    }) => (typeof e == "number" && (e = "" + e), e != null ? q(e) || X(e) || A(e) ? {
        i: ve,
        r: e,
        k: t,
        f: !!s
    } : e : null);

function E(e, t = null, s = null, n = 0, i = null, r = e === ie ? 0 : 1, o = !1, c = !1) {
    const f = {
        __v_isVNode: !0,
        __v_skip: !0,
        type: e,
        props: t,
        key: t && pi(t),
        ref: t && kt(t),
        scopeId: Gn,
        slotScopeIds: null,
        children: s,
        component: null,
        suspense: null,
        ssContent: null,
        ssFallback: null,
        dirs: null,
        transition: null,
        el: null,
        anchor: null,
        target: null,
        targetAnchor: null,
        staticCount: 0,
        shapeFlag: r,
        patchFlag: n,
        dynamicProps: i,
        dynamicChildren: null,
        appContext: null,
        ctx: ve
    };
    return c ? (Bs(f, s), r & 128 && e.normalize(f)) : s && (f.shapeFlag |= q(s) ? 8 : 16), yt > 0 && !o && ue && (f.patchFlag > 0 || r & 6) && f.patchFlag !== 32 && ue.push(f), f
}
const xe = oo;

function oo(e, t = null, s = null, n = 0, i = null, r = !1) {
    if ((!e || e === Cr) && (e = We), ro(e)) {
        const c = tt(e, t, !0);
        return s && Bs(c, s), yt > 0 && !r && ue && (c.shapeFlag & 6 ? ue[ue.indexOf(e)] = c : ue.push(c)), c.patchFlag |= -2, c
    }
    if (bo(e) && (e = e.__vccOpts), t) {
        t = lo(t);
        let {
            class: c,
            style: f
        } = t;
        c && !q(c) && (t.class = Ee(c)), H(f) && (qn(f) && !O(f) && (f = Z({}, f)), t.style = Jt(f))
    }
    const o = q(e) ? 1 : wr(e) ? 128 : so(e) ? 64 : H(e) ? 4 : A(e) ? 2 : 0;
    return E(e, t, s, n, i, o, r, !0)
}

function lo(e) {
    return e ? qn(e) || Zt in e ? Z({}, e) : e : null
}

function tt(e, t, s = !1) {
    const {
        props: n,
        ref: i,
        patchFlag: r,
        children: o
    } = e, c = t ? ao(n || {}, t) : n;
    return {
        __v_isVNode: !0,
        __v_skip: !0,
        type: e.type,
        props: c,
        key: c && pi(c),
        ref: t && t.ref ? s && i ? O(i) ? i.concat(kt(t)) : [i, kt(t)] : kt(t) : i,
        scopeId: e.scopeId,
        slotScopeIds: e.slotScopeIds,
        children: o,
        target: e.target,
        targetAnchor: e.targetAnchor,
        staticCount: e.staticCount,
        shapeFlag: e.shapeFlag,
        patchFlag: t && e.type !== ie ? r === -1 ? 16 : r | 16 : r,
        dynamicProps: e.dynamicProps,
        dynamicChildren: e.dynamicChildren,
        appContext: e.appContext,
        dirs: e.dirs,
        transition: e.transition,
        component: e.component,
        suspense: e.suspense,
        ssContent: e.ssContent && tt(e.ssContent),
        ssFallback: e.ssFallback && tt(e.ssFallback),
        el: e.el,
        anchor: e.anchor,
        ctx: e.ctx,
        ce: e.ce
    }
}

function gt(e = " ", t = 0) {
    return xe(Xt, null, e, t)
}

function co(e, t) {
    const s = xe(Ft, null, e);
    return s.staticCount = t, s
}

function ft(e = "", t = !1) {
    return t ? (te(), io(We, null, e)) : xe(We, null, e)
}

function be(e) {
    return e == null || typeof e == "boolean" ? xe(We) : O(e) ? xe(ie, null, e.slice()) : typeof e == "object" ? Ie(e) : xe(Xt, null, String(e))
}

function Ie(e) {
    return e.el === null && e.patchFlag !== -1 || e.memo ? e : tt(e)
}

function Bs(e, t) {
    let s = 0;
    const {
        shapeFlag: n
    } = e;
    if (t == null) t = null;
    else if (O(t)) s = 16;
    else if (typeof t == "object")
        if (n & 65) {
            const i = t.default;
            i && (i._c && (i._d = !1), Bs(e, i()), i._c && (i._d = !0));
            return
        } else {
            s = 32;
            const i = t._;
            !i && !(Zt in t) ? t._ctx = ve : i === 3 && ve && (ve.slots._ === 1 ? t._ = 1 : (t._ = 2, e.patchFlag |= 1024))
        }
    else A(t) ? (t = {
        default: t,
        _ctx: ve
    }, s = 32) : (t = String(t), n & 64 ? (s = 16, t = [gt(t)]) : s = 8);
    e.children = t, e.shapeFlag |= s
}

function ao(...e) {
    const t = {};
    for (let s = 0; s < e.length; s++) {
        const n = e[s];
        for (const i in n)
            if (i === "class") t.class !== n.class && (t.class = Ee([t.class, n.class]));
            else if (i === "style") t.style = Jt([t.style, n.style]);
            else if (Ut(i)) {
                const r = t[i],
                    o = n[i];
                o && r !== o && !(O(r) && r.includes(o)) && (t[i] = r ? [].concat(r, o) : o)
            } else i !== "" && (t[i] = n[i])
    }
    return t
}

function _e(e, t, s, n = null) {
    he(e, t, 7, [s, n])
}
const fo = oi();
let uo = 0;

function ho(e, t, s) {
    const n = e.type,
        i = (t ? t.appContext : e.appContext) || fo,
        r = {
            uid: uo++,
            vnode: e,
            type: n,
            parent: t,
            appContext: i,
            root: null,
            next: null,
            subTree: null,
            effect: null,
            update: null,
            scope: new Ln(!0),
            render: null,
            proxy: null,
            exposed: null,
            exposeProxy: null,
            withProxy: null,
            provides: t ? t.provides : Object.create(i.provides),
            accessCache: null,
            renderCache: [],
            components: null,
            directives: null,
            propsOptions: ci(n, i),
            emitsOptions: Zn(n, i),
            emit: null,
            emitted: null,
            propsDefaults: j,
            inheritAttrs: n.inheritAttrs,
            ctx: j,
            data: j,
            props: j,
            attrs: j,
            slots: j,
            refs: j,
            setupState: j,
            setupContext: null,
            attrsProxy: null,
            slotsProxy: null,
            suspense: s,
            suspenseId: s ? s.pendingId : 0,
            asyncDep: null,
            asyncResolved: !1,
            isMounted: !1,
            isUnmounted: !1,
            isDeactivated: !1,
            bc: null,
            c: null,
            bm: null,
            m: null,
            bu: null,
            u: null,
            um: null,
            bum: null,
            da: null,
            a: null,
            rtg: null,
            rtc: null,
            ec: null,
            sp: null
        };
    return r.ctx = {
        _: r
    }, r.root = t ? t.root : r, r.emit = mr.bind(null, r), e.ce && e.ce(r), r
}
let V = null,
    js, Ye, hn = "__VUE_INSTANCE_SETTERS__";
(Ye = fs()[hn]) || (Ye = fs()[hn] = []), Ye.push(e => V = e), js = e => {
    Ye.length > 1 ? Ye.forEach(t => t(e)) : Ye[0](e)
};
const st = e => {
    js(e), e.scope.on()
},
    Ke = () => {
        V && V.scope.off(), js(null)
    };

function gi(e) {
    return e.vnode.shapeFlag & 4
}
let vt = !1;

function po(e, t = !1) {
    vt = t;
    const {
        props: s,
        children: n
    } = e.vnode, i = gi(e);
    Yr(e, s, i, t), Vr(e, n);
    const r = i ? go(e, t) : void 0;
    return vt = !1, r
}

function go(e, t) {
    const s = e.type;
    e.accessCache = Object.create(null), e.proxy = Ls(new Proxy(e.ctx, Br));
    const {
        setup: n
    } = s;
    if (n) {
        const i = e.setupContext = n.length > 1 ? _o(e) : null;
        st(e), it();
        const r = Me(n, e, 0, [e.props, i]);
        if (rt(), Ke(), Tn(r)) {
            if (r.then(Ke, Ke), t) return r.then(o => {
                pn(e, o, t)
            }).catch(o => {
                $t(o, e, 0)
            });
            e.asyncDep = r
        } else pn(e, r, t)
    } else mi(e, t)
}

function pn(e, t, s) {
    A(t) ? e.type.__ssrInlineRender ? e.ssrRender = t : e.render = t : H(t) && (e.setupState = Yn(t)), mi(e, s)
}
let gn;

function mi(e, t, s) {
    const n = e.type;
    if (!e.render) {
        if (!t && gn && !n.render) {
            const i = n.template || ks(e).template;
            if (i) {
                const {
                    isCustomElement: r,
                    compilerOptions: o
                } = e.appContext.config, {
                    delimiters: c,
                    compilerOptions: f
                } = n, u = Z(Z({
                    isCustomElement: r,
                    delimiters: c
                }, o), f);
                n.render = gn(i, u)
            }
        }
        e.render = n.render || de
    } {
        st(e), it();
        try {
            jr(e)
        } finally {
            rt(), Ke()
        }
    }
}

function mo(e) {
    return e.attrsProxy || (e.attrsProxy = new Proxy(e.attrs, {
        get(t, s) {
            return re(e, "get", "$attrs"), t[s]
        }
    }))
}

function _o(e) {
    const t = s => {
        e.exposed = s || {}
    };
    return {
        get attrs() {
            return mo(e)
        },
        slots: e.slots,
        emit: e.emit,
        expose: t
    }
}

function Hs(e) {
    if (e.exposed) return e.exposeProxy || (e.exposeProxy = new Proxy(Yn(Ls(e.exposed)), {
        get(t, s) {
            if (s in t) return t[s];
            if (s in ht) return ht[s](e)
        },
        has(t, s) {
            return s in t || s in ht
        }
    }))
}

function bo(e) {
    return A(e) && "__vccOpts" in e
}
const yo = (e, t) => ar(e, t, vt),
    vo = Symbol.for("v-scx"),
    xo = () => Rt(vo),
    Co = "3.3.9",
    wo = "http://www.w3.org/2000/svg",
    je = typeof document < "u" ? document : null,
    mn = je && je.createElement("template"),
    Eo = {
        insert: (e, t, s) => {
            t.insertBefore(e, s || null)
        },
        remove: e => {
            const t = e.parentNode;
            t && t.removeChild(e)
        },
        createElement: (e, t, s, n) => {
            const i = t ? je.createElementNS(wo, e) : je.createElement(e, s ? {
                is: s
            } : void 0);
            return e === "select" && n && n.multiple != null && i.setAttribute("multiple", n.multiple), i
        },
        createText: e => je.createTextNode(e),
        createComment: e => je.createComment(e),
        setText: (e, t) => {
            e.nodeValue = t
        },
        setElementText: (e, t) => {
            e.textContent = t
        },
        parentNode: e => e.parentNode,
        nextSibling: e => e.nextSibling,
        querySelector: e => je.querySelector(e),
        setScopeId(e, t) {
            e.setAttribute(t, "")
        },
        insertStaticContent(e, t, s, n, i, r) {
            const o = s ? s.previousSibling : t.lastChild;
            if (i && (i === r || i.nextSibling))
                for (; t.insertBefore(i.cloneNode(!0), s), !(i === r || !(i = i.nextSibling)););
            else {
                mn.innerHTML = n ? `<svg>${e}</svg>` : e;
                const c = mn.content;
                if (n) {
                    const f = c.firstChild;
                    for (; f.firstChild;) c.appendChild(f.firstChild);
                    c.removeChild(f)
                }
                t.insertBefore(c, s)
            }
            return [o ? o.nextSibling : t.firstChild, s ? s.previousSibling : t.lastChild]
        }
    },
    So = Symbol("_vtc");

function To(e, t, s) {
    const n = e[So];
    n && (t = (t ? [t, ...n] : [...n]).join(" ")), t == null ? e.removeAttribute("class") : s ? e.setAttribute("class", t) : e.className = t
}
const Oo = Symbol("_vod");

function Po(e, t, s) {
    const n = e.style,
        i = q(s);
    if (s && !i) {
        if (t && !q(t))
            for (const r in t) s[r] == null && xs(n, r, "");
        for (const r in s) xs(n, r, s[r])
    } else {
        const r = n.display;
        i ? t !== s && (n.cssText = s) : t && e.removeAttribute("style"), Oo in e && (n.display = r)
    }
}
const _n = /\s*!important$/;

function xs(e, t, s) {
    if (O(s)) s.forEach(n => xs(e, t, n));
    else if (s == null && (s = ""), t.startsWith("--")) e.setProperty(t, s);
    else {
        const n = Io(e, t);
        _n.test(s) ? e.setProperty(nt(n), s.replace(_n, ""), "important") : e[n] = s
    }
}
const bn = ["Webkit", "Moz", "ms"],
    cs = {};

function Io(e, t) {
    const s = cs[t];
    if (s) return s;
    let n = Ge(t);
    if (n !== "filter" && n in e) return cs[t] = n;
    n = In(n);
    for (let i = 0; i < bn.length; i++) {
        const r = bn[i] + n;
        if (r in e) return cs[t] = r
    }
    return t
}
const yn = "http://www.w3.org/1999/xlink";

function Ao(e, t, s, n, i) {
    if (n && t.startsWith("xlink:")) s == null ? e.removeAttributeNS(yn, t.slice(6, t.length)) : e.setAttributeNS(yn, t, s);
    else {
        const r = Li(t);
        s == null || r && !An(s) ? e.removeAttribute(t) : e.setAttribute(t, r ? "" : s)
    }
}

function Mo(e, t, s, n, i, r, o) {
    if (t === "innerHTML" || t === "textContent") {
        n && o(n, i, r), e[t] = s ?? "";
        return
    }
    const c = e.tagName;
    if (t === "value" && c !== "PROGRESS" && !c.includes("-")) {
        e._value = s;
        const u = c === "OPTION" ? e.getAttribute("value") : e.value,
            m = s ?? "";
        u !== m && (e.value = m), s == null && e.removeAttribute(t);
        return
    }
    let f = !1;
    if (s === "" || s == null) {
        const u = typeof e[t];
        u === "boolean" ? s = An(s) : s == null && u === "string" ? (s = "", f = !0) : u === "number" && (s = 0, f = !0)
    }
    try {
        e[t] = s
    } catch { }
    f && e.removeAttribute(t)
}

function Lo(e, t, s, n) {
    e.addEventListener(t, s, n)
}

function Do(e, t, s, n) {
    e.removeEventListener(t, s, n)
}
const vn = Symbol("_vei");

function Ro(e, t, s, n, i = null) {
    const r = e[vn] || (e[vn] = {}),
        o = r[t];
    if (n && o) o.value = n;
    else {
        const [c, f] = Fo(t);
        if (n) {
            const u = r[t] = Bo(n, i);
            Lo(e, c, u, f)
        } else o && (Do(e, c, o, f), r[t] = void 0)
    }
}
const xn = /(?:Once|Passive|Capture)$/;

function Fo(e) {
    let t;
    if (xn.test(e)) {
        t = {};
        let n;
        for (; n = e.match(xn);) e = e.slice(0, e.length - n[0].length), t[n[0].toLowerCase()] = !0
    }
    return [e[2] === ":" ? e.slice(3) : nt(e.slice(2)), t]
}
let as = 0;
const ko = Promise.resolve(),
    No = () => as || (ko.then(() => as = 0), as = Date.now());

function Bo(e, t) {
    const s = n => {
        if (!n._vts) n._vts = Date.now();
        else if (n._vts <= s.attached) return;
        he(jo(n, s.value), t, 5, [n])
    };
    return s.value = e, s.attached = No(), s
}

function jo(e, t) {
    if (O(t)) {
        const s = e.stopImmediatePropagation;
        return e.stopImmediatePropagation = () => {
            s.call(e), e._stopped = !0
        }, t.map(n => i => !i._stopped && n && n(i))
    } else return t
}
const Cn = /^on[a-z]/,
    Ho = (e, t, s, n, i = !1, r, o, c, f) => {
        t === "class" ? To(e, n, i) : t === "style" ? Po(e, s, n) : Ut(t) ? ws(t) || Ro(e, t, s, n, o) : (t[0] === "." ? (t = t.slice(1), !0) : t[0] === "^" ? (t = t.slice(1), !1) : Ko(e, t, n, i)) ? Mo(e, t, n, r, o, c, f) : (t === "true-value" ? e._trueValue = n : t === "false-value" && (e._falseValue = n), Ao(e, t, n, i))
    };

function Ko(e, t, s, n) {
    return n ? !!(t === "innerHTML" || t === "textContent" || t in e && Cn.test(t) && A(s)) : t === "spellcheck" || t === "draggable" || t === "translate" || t === "form" || t === "list" && e.tagName === "INPUT" || t === "type" && e.tagName === "TEXTAREA" || Cn.test(t) && q(s) ? !1 : t in e
}
const Uo = Z({
    patchProp: Ho
}, Eo);
let wn;

function Wo() {
    return wn || (wn = Zr(Uo))
}
const qo = (...e) => {
    const t = Wo().createApp(...e),
        {
            mount: s
        } = t;
    return t.mount = n => {
        const i = zo(n);
        if (!i) return;
        const r = t._component;
        !A(r) && !r.render && !r.template && (r.template = i.innerHTML), i.innerHTML = "";
        const o = s(i, !1, i instanceof SVGElement);
        return i instanceof Element && (i.removeAttribute("v-cloak"), i.setAttribute("data-v-app", "")), o
    }, t
};

function zo(e) {
    return q(e) ? document.querySelector(e) : e
}
var Jo = !1;
/*!
 * pinia v2.1.7
 * (c) 2023 Eduardo San Martin Morote
 * @license MIT
 */
const Yo = Symbol();
var En;
(function (e) {
    e.direct = "direct", e.patchObject = "patch object", e.patchFunction = "patch function"
})(En || (En = {}));

function $o() {
    const e = Di(!0),
        t = e.run(() => nr({}));
    let s = [],
        n = [];
    const i = Ls({
        install(r) {
            i._a = r, r.provide(Yo, i), r.config.globalProperties.$pinia = i, n.forEach(o => s.push(o)), n = []
        },
        use(r) {
            return !this._a && !Jo ? n.push(r) : s.push(r), this
        },
        _p: s,
        _a: null,
        _e: e,
        _s: new Map,
        state: t
    });
    return i
}
const Qo = (e, t) => {
    const s = e.__vccOpts || e;
    for (const [n, i] of t) s[n] = i;
    return s
},
    Vo = {
        name: "App",
        components: {},
        data() {
            return {
                show: !1,
                serverName: "CypherRP",
                menuName: "Character Creator",
                menuSubTitle: "Barber Shop",
                menuDesc: "Cette interface vous permet de modifier votre personnage à votre guise.",
                selectedCategory: "heritage",
                variationsCount: 3,
                itemsList: [{
                    label: "Coupe n°1",
                    price: 65e3,
                    category: "hair",
                    id: 1
                }, {
                    label: "Coupe n°2",
                    price: 65e3,
                    category: "hair",
                    id: 2
                }, {
                    label: "Coupe n°3",
                    price: 65e3,
                    category: "hair",
                    id: 3
                }, {
                    label: "Coupe n°4",
                    price: 65e3,
                    category: "hair",
                    id: 4
                }, {
                    label: "Coupe n°5",
                    price: 65e3,
                    category: "hair",
                    id: 5
                }, {
                    label: "Coupe n°6",
                    price: 65e3,
                    category: "hair",
                    id: 6
                }, {
                    label: "Coupe n°7",
                    price: 65e3,
                    category: "hair",
                    id: 7
                }, {
                    label: "Coupe n°8",
                    price: 65e3,
                    category: "hair",
                    id: 8
                }, {
                    label: "Coupe n°9",
                    price: 65e3,
                    category: "hair",
                    id: 9
                }, {
                    label: "Coupe n°10",
                    price: 65e3,
                    category: "hair",
                    id: 10
                }, {
                    label: "Coupe n°11",
                    price: 65e3,
                    category: "hair",
                    id: 11
                }, {
                    label: "Coupe n°12",
                    price: 65e3,
                    category: "hair",
                    id: 12
                }, {
                    label: "Coupe n°13",
                    price: 65e3,
                    category: "hair",
                    id: 13
                }, {
                    label: "Coupe n°14",
                    price: 65e3,
                    category: "hair",
                    id: 14
                }, {
                    label: "Coupe n°15",
                    price: 65e3,
                    category: "hair",
                    id: 15
                }, {
                    label: "Coupe n°16",
                    price: 65e3,
                    category: "hair",
                    id: 16
                }, {
                    label: "Coupe n°17",
                    price: 65e3,
                    category: "hair",
                    id: 17
                }, {
                    label: "Coupe n°18",
                    price: 65e3,
                    category: "hair",
                    id: 18
                }, {
                    label: "Coupe n°19",
                    price: 65e3,
                    category: "hair",
                    id: 19
                }, {
                    label: "Coupe n°20",
                    price: 65e3,
                    category: "hair",
                    id: 20
                }, {
                    label: "Coupe n°21",
                    price: 65e3,
                    category: "hair",
                    id: 21
                }, {
                    label: "Coupe n°22",
                    price: 65e3,
                    category: "hair",
                    id: 22
                }, {
                    label: "Coupe n°23",
                    price: 65e3,
                    category: "hair",
                    id: 23
                }, {
                    label: "Coupe n°24",
                    price: 65e3,
                    category: "hair",
                    id: 24
                }, {
                    label: "Coupe n°25",
                    price: 65e3,
                    category: "hair",
                    id: 25
                }, {
                    label: "Coupe n°100",
                    price: 65e3,
                    category: "hair",
                    id: 100
                }],
                categories: {
                    heritage: {
                        label: "Génétique",
                        key: "heritage",
                        id: 3,
                        icon: "heritage"
                    },
                    hair: {
                        label: "Cheveux",
                        key: "hair",
                        id: 4,
                        icon: "hair"
                    },
                    beard: {
                        label: "Barbe",
                        key: "beard",
                        id: 1,
                        icon: "beard"
                    },
                    makeup: {
                        label: "Maquillage",
                        key: "makeup",
                        id: 2,
                        icon: "makeup"
                    },
                    lipstick: {
                        label: "Rouge à lèvres",
                        key: "lipstick",
                        id: 5,
                        icon: "lipstick"
                    }
                },
                variationsList: {
                    size: {
                        type: "range",
                        suffix: "_2",
                        label: "Taille"
                    },
                    primary: {
                        type: "range",
                        suffix: "_3",
                        label: "Couleur primaire"
                    },
                    secondary: {
                        type: "range",
                        suffix: "_4",
                        label: "Couleur secondaire"
                    }
                },
                parentsList: {
                    1: {
                        label: "Santiago",
                        id: 1,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    2: {
                        label: "Santiago",
                        id: 2,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    3: {
                        label: "Santiago",
                        id: 3,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    4: {
                        label: "Santiago",
                        id: 4,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    5: {
                        label: "Santiago",
                        id: 5,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    6: {
                        label: "Santiago",
                        id: 6,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    7: {
                        label: "Santiago",
                        id: 7,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    8: {
                        label: "Santiago",
                        id: 8,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    9: {
                        label: "Santiago",
                        id: 9,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    10: {
                        label: "Santiago",
                        id: 10,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    11: {
                        label: "Santiago",
                        id: 11,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    12: {
                        label: "Santiago",
                        id: 12,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    13: {
                        label: "Santiago",
                        id: 13,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    14: {
                        label: "Santiago",
                        id: 14,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    15: {
                        label: "Santiago",
                        id: 15,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    16: {
                        label: "Santiago",
                        id: 16,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    17: {
                        label: "Santiago",
                        id: 17,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    18: {
                        label: "Santiago",
                        id: 18,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    19: {
                        label: "Santiago",
                        id: 19,
                        img: "./assets/img/parents/Santiago.png"
                    },
                    20: {
                        label: "Santiago",
                        id: 20,
                        img: "./assets/img/parents/Santiago.png"
                    }
                },
                skinData: {},
                characterData: {
                    heritage: {
                        selected: "dad",
                        dad: 1,
                        mom: 1,
                        shapeMix: .5,
                        skinMix: .5
                    }
                }
            }
        },
        methods: {
            handleHeritageChange: function (e, t) {
                e == "shape" ? (this.characterData.heritage.shapeMix = t, this.updateSkinData("face_md_weight", this.characterData.heritage.shapeMix)) : e == "skin" && (this.characterData.heritage.skinMix = t, this.updateSkinData("skin_md_weight", this.characterData.heritage.skinMix))
            },
            handleParentChange: function (e, t) {
                this.characterData.heritage[e] = t, this.updateSkinData(e, t)
            },
            updateSkinData: function (e, t, s) {
                s !== void 0 && t > s && (t = s), this.skinData[e] = t, this.post("updateSkinData", {
                    key: e,
                    value: t
                })
            },
            selectCategory: function (e) {
                this.post("selectCategory", {
                    key: e
                })
            },
            close: function () {
                this.post("close", {})
            },
            validate: function () {
                this.post("validate", {
                    skinData: this.skinData
                })
            },
            sortedListById: function (e) {
                var t = [];
                var index = 1;
                for (var s in e) {
                    let n = e[s].id || index++; // Assign an incremental id if none exists
                    t.push({ ...e[s], id: n, tableKey: s });
                }
                return t;
            }
        },
        mounted() {
            this.messageListener = window.addEventListener("message", t => {
                const s = t.data;
                s.show !== void 0 && (this.show = s.show), s.menuName !== void 0 && (this.menuName = s.menuName), s.menuSubTitle !== void 0 && (this.menuSubTitle = s.menuSubTitle), s.menuDesc !== void 0 && (this.menuDesc = s.menuDesc), s.categories !== void 0 && (this.categories = s.categories), s.itemsList !== void 0 && (this.itemsList = s.itemsList), s.variationsCount !== void 0 && (this.variationsCount = s.variationsCount), s.variationsList !== void 0 && (this.variationsList = s.variationsList), s.parentsList !== void 0 && (this.parentsList = s.parentsList), s.skinData !== void 0 && (this.skinData = s.skinData), s.characterData !== void 0 && (this.characterData = s.characterData), s.selectedCategory !== void 0 && (this.selectedCategory = s.selectedCategory), s.serverName !== void 0 && (this.serverName = s.serverName)
            });
            const e = this;
            window.addEventListener("keyup", function (t) {
                t.key === "Escape" && e.close()
            }), window.addEventListener("keydown", function (t) {
                t.key === "ArrowRight" ? e.post("setCamAngle", 1) : t.key === "ArrowLeft" ? e.post("setCamAngle", -1) : t.key === "ArrowUp" || t.key
            }), this.post = function (t, s) {
                return fetch(`https://ui-skinchanger/${t}`, {
                    method: "post",
                    headers: {
                        "Content-type": "application/json; charset=UTF-8"
                    },
                    body: JSON.stringify(s)
                })
            }
        }
    },
    Xo = {
        class: "topSide"
    },
    Zo = {
        class: "titleBox"
    },
    Go = E("div", {
        class: "titleIcon"
    }, [E("i", {
        class: "fa-solid fa-bars"
    })], -1),
    el = {
        class: "titleTextBox"
    },
    tl = {
        class: "titleText",
        style: {
            "text-transform": "uppercase"
        }
    },
    sl = {
        class: "titleSubText",
        style: {
            "text-transform": "uppercase"
        }
    },
    nl = E("div", {
        class: "line"
    }, null, -1),
    il = {
        class: "infoBox"
    },
    rl = {
        class: "infoText",
        style: {
            "text-transform": "uppercase"
        }
    },
    ol = {
        class: "infoSubText"
    },
    ll = {
        class: "bottomSide"
    },
    cl = {
        class: "categorySide"
    },
    al = E("div", {
        class: "categoryTitle"
    }, [gt(" SELECT "), E("p", null, "CATEGORY")], -1),
    fl = E("div", {
        class: "categoryLine"
    }, null, -1),
    ul = {
        class: "categoryList"
    },
    dl = E("svg", {
        viewBox: "0 0 32 32",
        fill: "none",
        xmlns: "http://www.w3.org/2000/svg"
    }, [E("g", {
        id: "mdi:arrow-up-bold"
    }, [E("path", {
        id: "Vector",
        d: "M5.33331 20L5.33331 12L16 12L16 5.54663L26.4533 16L16 26.4533L16 20L5.33331 20Z"
    })])], -1),
    hl = [dl],
    pl = E("div", {
        class: "categoryLine"
    }, null, -1),
    gl = ["itemid", "onClick"],
    ml = ["src"],
    _l = E("div", {
        class: "bottomLine"
    }, null, -1),
    bl = {
        class: "menuSide",
        style: "display: flex;"
    },
    yl = {
        class: "menuBox"
    },
    vl = {
        class: "menuTitle"
    },
    xl = {
        key: 0,
        class: "menuList"
    },
    Cl = ["onClick"],
    wl = {
        class: "menuName"
    },
    El = {
        class: "menuPrice"
    },
    Sl = {
        key: 1,
        class: "menuListss"
    },
    Tl = {
        class: "parentsBox"
    },
    Ol = {
        class: "parentsButtonList"
    },
    Pl = {
        class: "parentList"
    },
    Il = ["onClick"],
    Al = {
        class: "parentName"
    },
    Ml = ["src"],
    Ll = {
        class: "rangeBox"
    },
    Dl = {
        class: "range"
    },
    Rl = {
        class: "rangeSay"
    },
    Fl = ["value"],
    kl = {
        class: "itemCount"
    },
    Nl = {
        class: "rangeBox"
    },
    Bl = {
        class: "range"
    },
    jl = {
        class: "rangeSay"
    },
    Hl = ["value"],
    Kl = {
        class: "itemCount"
    },
    Ul = {
        key: 0,
        class: "menuDetails"
    },
    Wl = E("div", {
        class: "menuTitle"
    }, "Variations", -1),
    ql = {
        key: 0,
        class: "colorList"
    },
    zl = co('<div class="colorArrow"><i class="fa-solid fa-chevron-left"></i></div><div class="color"></div><div class="color" style="background:#420f03;"></div><div class="color" style="background:#c0851a;"></div><div class="color" style="background:#d40a37;"></div><div class="color" style="background:#d8e935;"></div><div class="color" style="background:#f3c539;"></div><div class="color" style="background:#64ed13;"></div><div class="color" style="background:#cc8fd0;"></div><div class="color" style="background:#5972c3;"></div><div class="colorArrow" style="transform:rotate(180deg);"><i class="fa-solid fa-chevron-left"></i></div>', 11),
    Jl = [zl],
    Yl = {
        key: 1,
        class: "range"
    },
    $l = {
        class: "rangeSay"
    },
    Ql = ["min", "max", "value", "onInput"],
    Vl = ["value", "max", "onInput"],
    Xl = E("div", {
        class: "generalButtonList"
    }, [E("div", {
        class: "saveButton",
        style: {
            display: "none"
        }
    }, "Acheter à l'unité")], -1),
    Zl = E("link", {
        rel: "stylesheet",
        href: "https://fonts.googleapis.com/css2?family=Barlow:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap",
        crossorigin: "anonymous",
        referrerpolicy: "no-referrer"
    }, null, -1),
    Gl = E("link", {
        rel: "stylesheet",
        href: "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css",
        integrity: "sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==",
        crossorigin: "anonymous",
        referrerpolicy: "no-referrer"
    }, null, -1);

function ec(e, t, s, n, i, r) {
    return te(), se(ie, null, [E("div", {
        class: "General",
        style: Jt(i.show == !1 ? "display: none;" : "")
    }, [E("div", Xo, [E("div", Zo, [Go, E("div", el, [E("h2", tl, ce(i.serverName), 1), E("p", sl, ce(i.menuName), 1)])]), nl, E("div", il, [E("h2", rl, ce(i.menuSubTitle), 1), E("p", ol, ce(i.menuDesc), 1)])]), E("div", ll, [E("div", cl, [al, fl, E("div", ul, [E("div", {
        class: "category",
        onClick: t[0] || (t[0] = o => r.validate())
    }, hl), pl, (te(!0), se(ie, null, Mt(r.sortedListById(i.categories), (o, c) => (te(), se("div", {
        class: Ee(["category", i.selectedCategory == o.tableKey ? "selectCategory" : ""]),
        itemid: o.id,
        onClick: f => r.selectCategory(o.tableKey)
    }, [E("img", {
        src: `./assets/img/icons/white/${o.icon}.svg`
    }, null, 8, ml)], 10, gl))), 256))])]), _l, E("div", bl, [E("div", yl, [E("div", vl, ce(i.categories[i.selectedCategory].label), 1), i.selectedCategory !== "heritage" ? (te(), se("div", xl, [(te(!0), se(ie, null, Mt(i.itemsList, (o, c) => (te(), se("div", {
        class: Ee(["menu", (i.skinData[i.selectedCategory + (i.variationsCount > 0 ? "_1" : "")] || 0) == o.id ? "selectMenu" : ""]),
        key: o.id,
        onClick: f => r.updateSkinData(i.selectedCategory + (i.variationsCount > 0 ? "_1" : ""), o.id)
    }, [E("h2", wl, ce(o.label), 1), E("p", El, "$" + ce(o.price.toLocaleString()), 1)], 10, Cl))), 128))])) : ft("", !0), i.selectedCategory == "heritage" ? (te(), se("div", Sl, [E("div", Tl, [E("div", Ol, [E("div", {
        class: Ee(["parentsButton", i.characterData.heritage.selected == "dad" ? "selectedParentButton" : ""]),
        onClick: t[1] || (t[1] = o => i.characterData.heritage.selected = "dad")
    }, "Dad", 2), E("div", {
        class: Ee(["parentsButton", i.characterData.heritage.selected == "mom" ? "selectedParentButton" : ""]),
        onClick: t[2] || (t[2] = o => i.characterData.heritage.selected = "mom")
    }, "Mom", 2)]), E("div", Pl, [(te(!0), se(ie, null, Mt(r.sortedListById(i.parentsList), (o, c) => (te(), se("div", {
        class: Ee(["parent", i.characterData.heritage[i.characterData.heritage.selected] == o.id ? "selectParent" : ""]),
        key: o.id,
        onClick: f => r.handleParentChange(i.characterData.heritage.selected, o.id)
    }, [E("h2", Al, ce(o.label), 1), E("img", {
        src: o.img,
        alt: "",
        class: "parentImg"
    }, null, 8, Ml)], 10, Il))), 128))])]), E("div", Ll, [gt(" Similarité faciale avec Père - Mère "), E("div", Dl, [E("div", Rl, [E("input", {
        type: "range",
        min: "0",
        max: "100",
        step: "1",
        value: i.skinData.shape_mix || 0,
        onInput: t[3] || (t[3] = o => r.handleHeritageChange("shape", o.target.value)),
        class: "rangeSayLine",
        style: {
            background: "rgba(255, 255, 255, 0.54)"
        }
    }, null, 40, Fl)]), E("div", kl, "%" + ce(i.skinData.shape_mix || 0), 1)])]), E("div", Nl, [gt(" Similarité colorimétrique avec Père - Mère "), E("div", Bl, [E("div", jl, [E("input", {
        type: "range",
        min: "0",
        max: "100",
        step: "1",
        value: i.skinData.skin_mix || 0,
        onInput: t[4] || (t[4] = o => r.handleHeritageChange("skin", o.target.value)),
        class: "rangeSayLine",
        style: {
            background: "rgba(255, 255, 255, 0.54)"
        }
    }, null, 40, Hl)]), E("div", Kl, "%" + ce(i.skinData.skin_mix || 0), 1)])])])) : ft("", !0)]), i.variationsCount > 0 && i.selectedCategory !== "heritage" ? (te(), se("div", Ul, [Wl, (te(!0), se(ie, null, Mt(r.sortedListById(i.variationsList), (o, c) => (te(), se("div", {
        key: o.id,
        class: Ee(o.type == "color" ? "colorMenu" : o.type == "range" ? "rangeBox" : "")
    }, [gt(ce(o.label) + " ", 1), o.type == "color" ? (te(), se("div", ql, Jl)) : ft("", !0), o.type == "range" ? (te(), se("div", Yl, [E("div", $l, [E("input", {
        type: "range",
        min: o.min || 0,
        max: o.max || 100,
        value: i.skinData[i.selectedCategory + o.suffix] || 0,
        onInput: f => r.updateSkinData(i.selectedCategory + o.suffix, f.target.value),
        class: "rangeSayLine",
        style: {
            background: "rgba(255, 255, 255, 0.54)"
        }
    }, null, 40, Ql)]), E("input", {
        class: "itemCount",
        value: i.skinData[i.selectedCategory + o.suffix] || 0,
        min: 0,
        max: o.max || 100,
        onInput: f => r.updateSkinData(i.selectedCategory + o.suffix, f.target.value, o.max)
    }, null, 40, Vl)])) : ft("", !0)], 2))), 128))])) : ft("", !0)])]), Xl], 4), Zl, Gl], 64)
}
const tc = Qo(Vo, [
    ["render", ec]
]),
    _i = qo(tc);
_i.use($o());
_i.mount("#app");