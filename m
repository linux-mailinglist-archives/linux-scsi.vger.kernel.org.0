Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C494FDBA6
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Apr 2022 12:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbiDLKFl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Apr 2022 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355011AbiDLIGo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Apr 2022 04:06:44 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3AAD4A3D4;
        Tue, 12 Apr 2022 00:37:07 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,253,1643641200"; 
   d="scan'208";a="116447073"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 12 Apr 2022 16:37:06 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BF08B400F4F6;
        Tue, 12 Apr 2022 16:37:06 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/7] treewide: scsi: ufs: Add support for Renesas R-Car UFS controller
Date:   Tue, 12 Apr 2022 16:36:40 +0900
Message-Id: <20220412073647.3808493-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch series adds support Renesas R-Car S4-8 UFS controller.
This controller has some restrictions so adds some quirks for it.
Before using this driver, we have to initialize a clock generator
on the environment board (named "Spider") by using the commands of
U-Boot like below:
 => i2c dev 0
 => i2c mw 0x6c 0x26 0x05
 => i2c olen 0x6c 2
 => i2c mw 0x6c 0x26c 0x2e

To use the UFS controller, we need the following patch too:
https://lore.kernel.org/all/20220411124932.3765571-1-yoshihiro.shimoda.uh@renesas.com/

Yoshihiro Shimoda (7):
  dt-bindings: ufs: Document Renesas R-Car UFS host controller
  ufs: add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
  ufs: add UFSHCD_QUIRK_HIBERN_FASTAUTO
  scsi: ufs-renesas: Add support for Renesas R-Car UFS controller
  scsi: MAINTAINERS: Add maintainer for Renesas UFS driver
  arm64: dts: renesas: r8a779f0: Add UFS node
  arm64: dts: renesas: r8a779f0: spider-cpu: Enable UFS device

 .../devicetree/bindings/ufs/renesas,ufs.yaml  |  63 +++
 MAINTAINERS                                   |   7 +
 .../boot/dts/renesas/r8a779f0-spider-cpu.dtsi |   8 +
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi     |  19 +
 drivers/scsi/ufs/Kconfig                      |  12 +
 drivers/scsi/ufs/Makefile                     |   1 +
 drivers/scsi/ufs/ufs-renesas.c                | 418 ++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                     |  12 +-
 drivers/scsi/ufs/ufshcd.h                     |  12 +
 9 files changed, 549 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/renesas,ufs.yaml
 create mode 100644 drivers/scsi/ufs/ufs-renesas.c

-- 
2.25.1

