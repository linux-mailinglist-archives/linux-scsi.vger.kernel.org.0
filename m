Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A751E52EC
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2020 03:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgE1Bc3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 May 2020 21:32:29 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:34332 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE1Bc2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 May 2020 21:32:28 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200528013225epoutp0473c6e58e6772b74cc419b7e01136bbaf~TDSTLtCVC2592825928epoutp04_
        for <linux-scsi@vger.kernel.org>; Thu, 28 May 2020 01:32:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200528013225epoutp0473c6e58e6772b74cc419b7e01136bbaf~TDSTLtCVC2592825928epoutp04_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590629545;
        bh=EJQ586JopX9Nh+Jh0icLV762x4EESw3HLRqH83Yavmg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=vAuLyTOl0CrEiBsBxFLRp8V6imN6mP3wVem6Jq03g2A63+/baepXNMmgKS0la7ya0
         zn9ls/eByZkMo0DEczpqqeDX7Wn+KJOHwMUzgMeRVzNsYdxVCRIImC1ahB0MFcIGdH
         c4tzx/VJT7jzDKUqLBpLeyyDcwGN74STz1saRoR4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200528013224epcas5p2e945060b01cc61366cf8310047df34f2~TDSSmmRgG3096730967epcas5p2w;
        Thu, 28 May 2020 01:32:24 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.00.09467.8A41FCE5; Thu, 28 May 2020 10:32:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200528013223epcas5p2be85fa8803326b49a905fb7225992cad~TDSSDAwLU3096230962epcas5p2t;
        Thu, 28 May 2020 01:32:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200528013223epsmtrp2348ccf7a091d69ebd31b1db094d286b0~TDSSCDIuH2107921079epsmtrp2Z;
        Thu, 28 May 2020 01:32:23 +0000 (GMT)
X-AuditID: b6c32a49-a3fff700000024fb-05-5ecf14a8d79f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.E7.08382.7A41FCE5; Thu, 28 May 2020 10:32:23 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200528013221epsmtip1a5775f5d5fdb105d87d0b9b91a772846~TDSQLuTaF1652016520epsmtip1g;
        Thu, 28 May 2020 01:32:21 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        krzk@kernel.org, avri.altman@wdc.com, martin.petersen@oracle.com,
        kwmad.kim@samsung.com, stanley.chu@mediatek.com,
        cang@codeaurora.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v10 00/10] exynos-ufs: Add support for UFS HCI
Date:   Thu, 28 May 2020 06:46:48 +0530
Message-Id: <20200528011658.71590-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7bCmlu4KkfNxBvc/SVg8mLeNzeLlz6ts
        Fp/WL2O1mH/kHKvF+fMb2C1ubjnKYrHp8TVWi8u75rBZzDi/j8mi+/oONovlx/8xWfzfs4Pd
        YunWm4wOvB6X+3qZPDat6mTz2Lyk3qPl5H4Wj49Pb7F49G1ZxejxeZOcR/uBbqYAjigum5TU
        nMyy1CJ9uwSujO93uhgL/spUnLvynLWBcbFYFyMnh4SAiUTH2xdsILaQwG5GiZWzCroYuYDs
        T4wSnQe+M0M43xgl7i98wA7TsWFnBytEYi+jxMLpR9kgnBYmien3H4DNYhPQlrg7fQsTiC0i
        ICxx5FsbI4jNLHCDSeLBSpcuRg4OYQE7ic9XykHCLAKqEhPXbQUr4RWwkVg9ZR8rxDJ5idUb
        DjBDxAUlTs58wgIxRl6ieetsZoiauRwS8/o0IGwXia/zVzBB2MISr45vgTpaSuLzu71sIGsl
        BLIlenYZQ4RrJJbOO8YCYdtLHLgyhwWkhFlAU2L9Ln2ITXwSvb+fMEF08kp0tAlBVKtKNL+7
        CtUpLTGxu5sVosRDoq9JFBKcsRK7r51imcAoNwvJ+bOQnD8LYdcCRuZVjJKpBcW56anFpgWG
        eanlesWJucWleel6yfm5mxjB6UjLcwfj3Qcf9A4xMnEwHmKU4GBWEuF1Ons6Tog3JbGyKrUo
        P76oNCe1+BCjNAeLkjiv0o8zcUIC6YklqdmpqQWpRTBZJg5OqQYmy1MnE03j5y7x9Hj6+67T
        na+39+ysOLv79+rSP9yN/6fvN7afxdkq9pJH9+DF31NFK04FqStpGzWd37FYev2NXK7WPm89
        ddXw2gdfTiRXxS8TfR34Ys/U/1MeXjNIbp245pzkvJC7gqrPLjBZvWOPMk6er+Y403bdFyu5
        I61HcrYvNe+QOsEvz/MghclS7/6u3ilOa7KmRvuEr0uvNjffFZMbsnsnl89eV/etc0sPSt+6
        pao2exPjlsqJ257yzn3IHP/6w5+N6Wpu2uUraqLYTpvrz5DzK77aaxcWYzn9UhBf1MYq4+YY
        JZd/bktL72tM+WAus2qfoNa3WcVOBpKhcya8XXfW4dhk096om609SizFGYmGWsxFxYkAB4xb
        iLYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnO5ykfNxBk/W6ls8mLeNzeLlz6ts
        Fp/WL2O1mH/kHKvF+fMb2C1ubjnKYrHp8TVWi8u75rBZzDi/j8mi+/oONovlx/8xWfzfs4Pd
        YunWm4wOvB6X+3qZPDat6mTz2Lyk3qPl5H4Wj49Pb7F49G1ZxejxeZOcR/uBbqYAjigum5TU
        nMyy1CJ9uwSujO93uhgL/spUnLvynLWBcbFYFyMnh4SAicSGnR2sXYxcHEICuxklVryeyQSR
        kJa4vnECO4QtLLHy33N2iKImJollvasYQRJsAtoSd6dvAWsQASo68q0NLM4s8IxJ4tTD0i5G
        Dg5hATuJz1fKQcIsAqoSE9dtBSvhFbCRWD1lHyvEfHmJ1RsOMEPEBSVOznzCAtLKLKAusX6e
        EMREeYnmrbOZJzDyz0JSNQuhahaSqgWMzKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3
        MYIjRUtzB+P2VR/0DjEycTAeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+N
        woVxQgLpiSWp2ampBalFMFkmDk6pBqbaI08f8/pwzsz7zqC2/Fu1+u8Ji5j+2mV0zzRSvMOx
        z/7kvHcq8bGVPHO4gmZJ2ftKrrb+8N+w64fgo64J/Tlcwle+qJzX9DgsaCMX0TfvcerxrQuO
        z9jZx/B8b8wn8yCf4vun3GYsuLdhSUrFz9hlKy8aHAnU31Qcrjt5m3bY7rbg02HN6/IUJFKW
        CQrqfuj+kvnlEKvB02C3TDYLnoS6fa/k93RzsbPVzitUDWG0Y+P2OjD1klRlc+LLe3NWq68I
        TEtSrtndzuHIeXh/dvX0WZ43O//OmnipuWWx/bJg3W2d9gWxtdPuGL9Nm+DBdfzvjH3Gvadn
        GyzuqrIQiBHXulf3JCfeOfPApHUF75RYijMSDbWYi4oTAf4RRjgDAwAA
X-CMS-MailID: 20200528013223epcas5p2be85fa8803326b49a905fb7225992cad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200528013223epcas5p2be85fa8803326b49a905fb7225992cad
References: <CGME20200528013223epcas5p2be85fa8803326b49a905fb7225992cad@epcas5p2.samsung.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch-set introduces UFS (Universal Flash Storage) host controller support
for Samsung family SoC. Mostly, it consists of UFS PHY and host specific driver.

- Changes since v9
* fixed the review comments by Rob on ufs dt bindings
* Addeded Rob's reviwed-by tag on 08/10 patch

- Changes since v8
* fixed make dt_binding_check error as pointed by Rob
* Addressed review comments from Randy Dunlap

- Changes since v7:
* fixed review comments from Rob and Kishon
* Addeded reviwed-by tags
* rebased on top of v5.7-rc4
 
- Changes since v6:
* Addressed review comments from Avri and Christoph
* Added Reviewed-by tags of Avri and Can on various patches

- Changes since v5:
* re-introduce various quicks which was removed because of no driver
* consumer of those quirks, initial 4 patches does the same.
* Added Reviewed-by tags
* rebased on top of v5.7-rc1
* included Kiwoong's patch in this series, which this driver needs

- Changes since v4:
* Addressed review comments from Avir and Rob 
* Minor improvment on the ufs phy and ufshc drivers
* Added Tested-by from Pawel
* Change UFS binding to DT schema format


- Changes since v3:
* Addressed Kishon's and Avir's review comments
* fixed make dt_binding_check error as pointed by Rob 

- Changes since v2:
* fixed build warning by kbuild test robot 
* Added Reported-by tags

- Changes since v1:
* fixed make dt_binding_check error as pointed by Rob
* Addressed Krzysztof's review comments
* Added Reviewed-by tags

Note: This series is based on Linux-5.7-rc4 (commit: 0e698dfa2822)

Alim Akhtar (9):
  scsi: ufs: add quirk to fix mishandling utrlclr/utmrlclr
  scsi: ufs: add quirk to disallow reset of interrupt aggregation
  scsi: ufs: add quirk to enable host controller without hce
  scsi: ufs: introduce UFSHCD_QUIRK_PRDT_BYTE_GRAN quirk
  dt-bindings: phy: Document Samsung UFS PHY bindings
  phy: samsung-ufs: add UFS PHY driver for samsung SoC
  dt-bindings: ufs: Add bindings for Samsung ufs host
  scsi: ufs-exynos: add UFS host support for Exynos SoCs
  arm64: dts: Add node for ufs exynos7

Kiwoong Kim (1):
  scsi: ufs: add quirk to fix abnormal ocs fatal error

 .../bindings/phy/samsung,ufs-phy.yaml         |   75 +
 .../bindings/ufs/samsung,exynos-ufs.yaml      |   89 ++
 .../boot/dts/exynos/exynos7-espresso.dts      |    4 +
 arch/arm64/boot/dts/exynos/exynos7.dtsi       |   43 +-
 drivers/phy/samsung/Kconfig                   |    9 +
 drivers/phy/samsung/Makefile                  |    1 +
 drivers/phy/samsung/phy-exynos7-ufs.h         |   86 ++
 drivers/phy/samsung/phy-samsung-ufs.c         |  380 +++++
 drivers/phy/samsung/phy-samsung-ufs.h         |  143 ++
 drivers/scsi/ufs/Kconfig                      |   12 +
 drivers/scsi/ufs/Makefile                     |    1 +
 drivers/scsi/ufs/ufs-exynos.c                 | 1292 +++++++++++++++++
 drivers/scsi/ufs/ufs-exynos.h                 |  287 ++++
 drivers/scsi/ufs/ufshcd.c                     |  126 +-
 drivers/scsi/ufs/ufshcd.h                     |   29 +
 drivers/scsi/ufs/unipro.h                     |   33 +
 16 files changed, 2596 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
 create mode 100644 drivers/phy/samsung/phy-exynos7-ufs.h
 create mode 100644 drivers/phy/samsung/phy-samsung-ufs.c
 create mode 100644 drivers/phy/samsung/phy-samsung-ufs.h
 create mode 100644 drivers/scsi/ufs/ufs-exynos.c
 create mode 100644 drivers/scsi/ufs/ufs-exynos.h


base-commit: 0e698dfa282211e414076f9dc7e83c1c288314fd
-- 
2.17.1

