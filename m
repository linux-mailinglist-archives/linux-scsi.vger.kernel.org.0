Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7A1EA45
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfD2SkO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 14:40:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59450 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2SkM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 14:40:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 688EB8077A; Mon, 29 Apr 2019 20:40:00 +0200 (CEST)
Date:   Mon, 29 Apr 2019 20:40:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/2] Revert the patches that rework sd probing
Message-ID: <20190429184008.GB24658@amd>
References: <20190429182153.206292-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <20190429182153.206292-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-04-29 11:21:51, Bart Van Assche wrote:
> Hi Martin,
>=20
> For a not yet fully root-caused reason patch "sd: Rely on the driver core
> for asynchronous probing" causes trouble with suspend/resume. Since not
> much time is left before the merge window opens, revert this patch and
> also a patch that depends on it.

Thank you.

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzHRQgACgkQMOfwapXb+vLHbACfVeb4uNMsqMtth8ApftcZNsZy
pMgAoIbLOb1RCrkR9Dw7zq8cw+EmejWu
=s8FU
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
