Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CE41D0DC
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 22:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfENUv2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 16:51:28 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35420 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENUv1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 16:51:27 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A91E4801FF; Tue, 14 May 2019 22:51:14 +0200 (CEST)
Date:   Tue, 14 May 2019 22:51:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] sd: Rely on the driver core for asynchronous
 probing
Message-ID: <20190514205129.GA29109@amd>
References: <20190430213919.97437-1-bvanassche@acm.org>
 <yq14l5xdknh.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <yq14l5xdknh.fsf@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series makes the sd driver rely on the driver core for
> > asynchronous probing. Although it's probably too late to submit this
> > patch series to Linus during the v5.2 merge window, I want to make
> > these patches available for review now.
>=20
> Applied to 5.3/scsi-queue (by hand). Thanks!

Previous versions broke suspend for me on x60... so I guess I should
test -next tommorow or day after that to see if it works now...?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzbKlEACgkQMOfwapXb+vIZOwCdHXQINGXrIqnmMEnjA9OU9TDV
HmoAnj4H5TSmM7LmvD8RmV6M/ftP+7RE
=01KP
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
