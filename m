Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0762D3324A3
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Mar 2021 13:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhCIMDD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Mar 2021 07:03:03 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:59998 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCIMCy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Mar 2021 07:02:54 -0500
Date:   Tue, 09 Mar 2021 12:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1615291373;
        bh=A9IJcMyhouZCZsf0lnor2ASG+/gwZAK4lhLBRl59pF8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=kUhL6rsKlX6zCgXLhnHGhBa3V94MSHyPlaXJWusJ+9bUjxpWw/dYf1fMZyy/hkIPT
         m0MODTakJxOcc66xIHPKPX8oZXgJyPs1htUnruaZrkTvIrrc247g1K0DYDUZkeZKOb
         wKYGVmCSMO5XtfA0xXFv2TTFKZYmliNtzK5/goag=
To:     caleb@connolly.tech, Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ejb@linux.ibm.com, stanley.chu@mediatek.com, cang@codeaurora.org,
        beanhuo@micron.com, jaegeuk@kernel.org, asutoshd@codeaurora.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [RESEND PATCH v2 1/3] scsi: ufshcd: use a function to calculate versions
Message-ID: <20210309120212.119451-2-caleb@connolly.tech>
In-Reply-To: <20210309120212.119451-1-caleb@connolly.tech>
References: <20210309120212.119451-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update the driver to use a function for referencing the UFS version.
This replaces the UFSHCI_VERSION_xy macros, and supports comparisons
where they did not.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 drivers/scsi/ufs/ufshcd.c | 64 +++++++++++++++++----------------------
 drivers/scsi/ufs/ufshci.h | 17 ++++++-----
 2 files changed, 37 insertions(+), 44 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 77161750c9fb..f4d4b885d4df 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -669,23 +669,12 @@ int ufshcd_wait_for_register(struct ufs_hba *hba, u32=
 reg, u32 mask,
  */
 static inline u32 ufshcd_get_intr_mask(struct ufs_hba *hba)
 {
-=09u32 intr_mask =3D 0;
+=09if (hba->ufs_version =3D=3D ufshci_version(1, 0))
+=09=09return INTERRUPT_MASK_ALL_VER_10;
+=09if (hba->ufs_version <=3D ufshci_version(2, 0))
+=09=09return INTERRUPT_MASK_ALL_VER_11;
=20
-=09switch (hba->ufs_version) {
-=09case UFSHCI_VERSION_10:
-=09=09intr_mask =3D INTERRUPT_MASK_ALL_VER_10;
-=09=09break;
-=09case UFSHCI_VERSION_11:
-=09case UFSHCI_VERSION_20:
-=09=09intr_mask =3D INTERRUPT_MASK_ALL_VER_11;
-=09=09break;
-=09case UFSHCI_VERSION_21:
-=09default:
-=09=09intr_mask =3D INTERRUPT_MASK_ALL_VER_21;
-=09=09break;
-=09}
-
-=09return intr_mask;
+=09return INTERRUPT_MASK_ALL_VER_21;
 }
=20
 /**
@@ -696,10 +685,22 @@ static inline u32 ufshcd_get_intr_mask(struct ufs_hba=
 *hba)
  */
 static inline u32 ufshcd_get_ufs_version(struct ufs_hba *hba)
 {
+=09u32 ufshci_ver;
+
 =09if (hba->quirks & UFSHCD_QUIRK_BROKEN_UFS_HCI_VERSION)
-=09=09return ufshcd_vops_get_ufs_hci_version(hba);
+=09=09ufshci_ver =3D ufshcd_vops_get_ufs_hci_version(hba);
+=09else
+=09=09ufshci_ver =3D ufshcd_readl(hba, REG_UFS_VERSION);
=20
-=09return ufshcd_readl(hba, REG_UFS_VERSION);
+=09/*
+=09 * UFSHCI v1.x uses a different version scheme, in order
+=09 * to allow the use of comparisons with the ufshci_version
+=09 * function, we convert it to the same scheme as ufs 2.0+.
+=09 */
+=09if (ufshci_ver & 0x00010000)
+=09=09return ufshci_version(1, ufshci_ver & 0x00000100);
+
+=09return ufshci_ver;
 }
=20
 /**
@@ -931,8 +932,7 @@ static inline bool ufshcd_is_hba_active(struct ufs_hba =
*hba)
 u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba)
 {
 =09/* HCI version 1.0 and 1.1 supports UniPro 1.41 */
-=09if ((hba->ufs_version =3D=3D UFSHCI_VERSION_10) ||
-=09    (hba->ufs_version =3D=3D UFSHCI_VERSION_11))
+=09if (hba->ufs_version <=3D ufshci_version(1, 1))
 =09=09return UFS_UNIPRO_VER_1_41;
 =09else
 =09=09return UFS_UNIPRO_VER_1_6;
@@ -2335,7 +2335,7 @@ static void ufshcd_enable_intr(struct ufs_hba *hba, u=
32 intrs)
 {
 =09u32 set =3D ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
=20
-=09if (hba->ufs_version =3D=3D UFSHCI_VERSION_10) {
+=09if (hba->ufs_version =3D=3D ufshci_version(1, 0)) {
 =09=09u32 rw;
 =09=09rw =3D set & INTERRUPT_MASK_RW_VER_10;
 =09=09set =3D rw | ((set ^ intrs) & intrs);
@@ -2355,7 +2355,7 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, =
u32 intrs)
 {
 =09u32 set =3D ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
=20
-=09if (hba->ufs_version =3D=3D UFSHCI_VERSION_10) {
+=09if (hba->ufs_version =3D=3D ufshci_version(1, 0)) {
 =09=09u32 rw;
 =09=09rw =3D (set & INTERRUPT_MASK_RW_VER_10) &
 =09=09=09~(intrs & INTERRUPT_MASK_RW_VER_10);
@@ -2518,8 +2518,7 @@ static int ufshcd_compose_devman_upiu(struct ufs_hba =
*hba,
 =09u8 upiu_flags;
 =09int ret =3D 0;
=20
-=09if ((hba->ufs_version =3D=3D UFSHCI_VERSION_10) ||
-=09    (hba->ufs_version =3D=3D UFSHCI_VERSION_11))
+=09if (hba->ufs_version <=3D ufshci_version(1, 1))
 =09=09lrbp->command_type =3D UTP_CMD_TYPE_DEV_MANAGE;
 =09else
 =09=09lrbp->command_type =3D UTP_CMD_TYPE_UFS_STORAGE;
@@ -2546,8 +2545,7 @@ static int ufshcd_comp_scsi_upiu(struct ufs_hba *hba,=
 struct ufshcd_lrb *lrbp)
 =09u8 upiu_flags;
 =09int ret =3D 0;
=20
-=09if ((hba->ufs_version =3D=3D UFSHCI_VERSION_10) ||
-=09    (hba->ufs_version =3D=3D UFSHCI_VERSION_11))
+=09if (hba->ufs_version <=3D ufshci_version(1, 1))
 =09=09lrbp->command_type =3D UTP_CMD_TYPE_SCSI;
 =09else
 =09=09lrbp->command_type =3D UTP_CMD_TYPE_UFS_STORAGE;
@@ -6561,15 +6559,10 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_=
hba *hba,
 =09ufshcd_prepare_lrbp_crypto(NULL, lrbp);
 =09hba->dev_cmd.type =3D cmd_type;
=20
-=09switch (hba->ufs_version) {
-=09case UFSHCI_VERSION_10:
-=09case UFSHCI_VERSION_11:
+=09if (hba->ufs_version <=3D ufshci_version(1, 1))
 =09=09lrbp->command_type =3D UTP_CMD_TYPE_DEV_MANAGE;
-=09=09break;
-=09default:
+=09else
 =09=09lrbp->command_type =3D UTP_CMD_TYPE_UFS_STORAGE;
-=09=09break;
-=09}
=20
 =09/* update the task tag in the request upiu */
 =09req_upiu->header.dword_0 |=3D cpu_to_be32(tag);
@@ -9298,10 +9291,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *m=
mio_base, unsigned int irq)
 =09/* Get UFS version supported by the controller */
 =09hba->ufs_version =3D ufshcd_get_ufs_version(hba);
=20
-=09if ((hba->ufs_version !=3D UFSHCI_VERSION_10) &&
-=09    (hba->ufs_version !=3D UFSHCI_VERSION_11) &&
-=09    (hba->ufs_version !=3D UFSHCI_VERSION_20) &&
-=09    (hba->ufs_version !=3D UFSHCI_VERSION_21))
+=09if (hba->ufs_version < ufshci_version(1, 0))
 =09=09dev_err(hba->dev, "invalid UFS version 0x%x\n",
 =09=09=09hba->ufs_version);
=20
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index 6795e1f0e8f8..e1eb44bacbe4 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -74,13 +74,16 @@ enum {
 #define MINOR_VERSION_NUM_MASK=09=09UFS_MASK(0xFFFF, 0)
 #define MAJOR_VERSION_NUM_MASK=09=09UFS_MASK(0xFFFF, 16)
=20
-/* Controller UFSHCI version */
-enum {
-=09UFSHCI_VERSION_10 =3D 0x00010000, /* 1.0 */
-=09UFSHCI_VERSION_11 =3D 0x00010100, /* 1.1 */
-=09UFSHCI_VERSION_20 =3D 0x00000200, /* 2.0 */
-=09UFSHCI_VERSION_21 =3D 0x00000210, /* 2.1 */
-};
+/*
+ * Controller UFSHCI version
+ * - 2.x and newer use the following scheme:
+ *   major << 8 + minor << 4
+ * - 1.x has been converted to match this in
+ *   ufshcd_get_ufs_version()
+ */
+static inline u32 ufshci_version(u32 major, u32 minor) {
+=09return (((major) << 8) + ((minor) << 4));
+}
=20
 /*
  * HCDDID - Host Controller Identification Descriptor
--=20
2.29.2


