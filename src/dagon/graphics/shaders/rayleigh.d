/*
Copyright (c) 2017-2018 Timur Gafarov

Boost Software License - Version 1.0 - August 17th, 2003
Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
*/

module dagon.graphics.shaders.rayleigh;

import std.stdio;
import std.math;
import std.conv;

import dlib.core.memory;
import dlib.math.vector;
import dlib.math.matrix;
import dlib.image.color;

import dagon.core.libs;
import dagon.core.ownership;
import dagon.graphics.rc;
import dagon.graphics.shader;

class RayleighShader: Shader
{
    string vs = import("Rayleigh.vs");
    string fs = import("Rayleigh.fs");

    this(Owner o)
    {
        auto myProgram = New!ShaderProgram(vs, fs, this);
        super(myProgram, o);
    }

    override void bind(RenderingContext* rc)
    {
        // Matrices
        setParameter("modelViewMatrix", rc.modelViewMatrix);
        setParameter("projectionMatrix", rc.projectionMatrix);
        setParameter("normalMatrix", rc.normalMatrix);
        setParameter("viewMatrix", rc.viewMatrix);
        setParameter("invViewMatrix", rc.invViewMatrix);
        setParameter("prevModelViewProjMatrix", rc.prevModelViewProjMatrix);
        setParameter("blurModelViewProjMatrix", rc.blurModelViewProjMatrix);
        
        setParameter("cameraPosition", rc.cameraPosition);

        // Environment
        setParameter("sunDirection", rc.environment.sunDirection);
        setParameter("sunColor", rc.environment.sunColor);
        setParameter("sunEnergy", rc.environment.sunEnergy);
        setParameter("skyZenithColor", rc.environment.skyZenithColor);
        setParameter("skyHorizonColor", rc.environment.skyHorizonColor);
        setParameter("groundColor", rc.environment.groundColor);
        setParameter("skyEnergy", rc.environment.skyEnergy);
        setParameter("groundEnergy", rc.environment.groundEnergy);
        setParameter("showSun", rc.environment.showSun);
        setParameter("showSunHalo", rc.environment.showSunHalo);
        setParameter("sunSize", rc.environment.sunSize);
        setParameter("sunScattering", rc.environment.sunScattering);

        super.bind(rc);
    }

    override void unbind(RenderingContext* rc)
    {
        super.unbind(rc);
    }
}
