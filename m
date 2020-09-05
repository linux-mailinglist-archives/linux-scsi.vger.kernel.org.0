Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0F25EAE7
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Sep 2020 23:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgIEVDH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Sep 2020 17:03:07 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:34639 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgIEVDG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 5 Sep 2020 17:03:06 -0400
Date:   Sat, 05 Sep 2020 21:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1599339783;
        bh=LMc0+1Hk9Afqm2G2fAFvBrU4ZxBzAUSkkiTlQeegv3s=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=nUA7y/Sn9q9y//BxtOdoNpUQnuv7q0AcPHKpHu7vsmNhgKtCQOVv2+ghMkLiHRjx7
         3wsnrmvURegws2+JgOYC0WJ8Km+hUm0G+RBkMOPRKJ/VfaYjnmBPe8EdNGeaA1iQnD
         z1Va/YFrz7JTG2uLW1r8QyeTuRDq+d1gy+avWtSE=
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: [PATCH] scsi: docs: Remove obsolete scsi typedef text from scsi_mid_low_api
Message-ID: <20200905210211.2286172-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Commit 91ebc1facd77 ("scsi: core: remove Scsi_Cmnd typedef") removed
the Scsi_cmnd typedef but it was still mentioned in a paragraph in the
"SCSI mid_level - lower_level driver interface" documentation page.
Remove this obsolete paragraph.

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
---

Hi,

Is this documentation page still relevant or should it be removed? I'm aski=
ng
since it hasn't been updated in a while and there's mention of 2.6 kernel.

In case it is still relevant, would patches changing the embedded kernel-do=
cs
for references to the kernel-docs in the source files be welcome?
Also, I see that for example, scsi_add_device, has a kernel-doc in this pag=
e,
even though there isn't any in the source code. Would a patch moving this
function description to the source code be welcome?

Thanks,
N=C3=ADcolas

 Documentation/scsi/scsi_mid_low_api.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/s=
csi_mid_low_api.rst
index 5358bc10689e..5bc17d012b25 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -271,12 +271,6 @@ Conventions
 First, Linus Torvalds's thoughts on C coding style can be found in the
 Documentation/process/coding-style.rst file.
=20
-Next, there is a movement to "outlaw" typedefs introducing synonyms for
-struct tags. Both can be still found in the SCSI subsystem, but
-the typedefs have been moved to a single file, scsi_typedefs.h to
-make their future removal easier, for example:
-"typedef struct scsi_cmnd Scsi_Cmnd;"
-
 Also, most C99 enhancements are encouraged to the extent they are supporte=
d
 by the relevant gcc compilers. So C99 style structure and array
 initializers are encouraged where appropriate. Don't go too far,
--=20
2.28.0


