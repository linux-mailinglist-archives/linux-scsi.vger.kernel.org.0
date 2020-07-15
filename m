Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F5220DA1
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jul 2020 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgGONHB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Jul 2020 09:07:01 -0400
Received: from mail1.g1.pair.com ([66.39.3.162]:55204 "EHLO mail1.g1.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbgGONHA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Jul 2020 09:07:00 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 09:07:00 EDT
Received: from mail1.g1.pair.com (localhost [127.0.0.1])
        by mail1.g1.pair.com (Postfix) with ESMTP id 539F25474B0;
        Wed, 15 Jul 2020 09:00:56 -0400 (EDT)
Received: from harpe.intellique.com (labo.djinux.com [82.225.196.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail1.g1.pair.com (Postfix) with ESMTPSA id B942260AF43;
        Wed, 15 Jul 2020 09:00:55 -0400 (EDT)
Date:   Wed, 15 Jul 2020 15:00:50 +0200
From:   Emmanuel Florac <eflorac@intellique.com>
To:     Sadegh Ali <sadegh.ali.2084@gmail.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: LIO Scsi Target
Message-ID: <20200715150050.27b7c59f@harpe.intellique.com>
In-Reply-To: <CA+RHgKLt=ZOu_nnL6oX=LJVtJWE9i+ARE6A_VmGLeJaU1mYtSg@mail.gmail.com>
References: <CA+RHgKLt=ZOu_nnL6oX=LJVtJWE9i+ARE6A_VmGLeJaU1mYtSg@mail.gmail.com>
Organization: Intellique
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/033V9_selw80ecPCpiFHet4"; protocol="application/pgp-signature"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--Sig_/033V9_selw80ecPCpiFHet4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le Wed, 15 Jul 2020 12:18:14 +0430
Sadegh Ali <sadegh.ali.2084@gmail.com> =C3=A9crivait:

> Dear sir
>=20
> we are considering to build SCSI Target system with ZFS filesystem
> backend using Linux
> I searched that two modules are available for Linux SCSI target, LIO,
> and SCST but it seems LIO project that streamed to the kernel is not
> updated for a while (about 7 years)
> Is the LIO module project dead? or suspended?
> Is any person or community available to respond to technical problems
> and fix bugs or develop new features or support new hardware?

LIO has been integrated into the mainline Linux kernel. The separate
project isn't updated because it's updated together with the kernel.
All common distributions provide the LIO modules and the target-cli
tools to manage LIO.

cheers,
--=20
------------------------------------------------------------------------
Emmanuel Florac     |   Direction technique
                    |   Intellique
                    |	<eflorac@intellique.com>
                    |   +33 1 78 94 84 02
------------------------------------------------------------------------

--Sig_/033V9_selw80ecPCpiFHet4
Content-Type: application/pgp-signature
Content-Description: Signature digitale OpenPGP

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAl8O/gsACgkQX3jQXNUicVadygCg834hOWXWPW0eneBTpBylP0w7
3nUAoMXOJSJEDiQ0qRBs89UiQ4hAFs0O
=/iL8
-----END PGP SIGNATURE-----

--Sig_/033V9_selw80ecPCpiFHet4--
