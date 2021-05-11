Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9335337AF9D
	for <lists+linux-scsi@lfdr.de>; Tue, 11 May 2021 21:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhEKTwu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 May 2021 15:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhEKTwk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 11 May 2021 15:52:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA293C06175F
        for <linux-scsi@vger.kernel.org>; Tue, 11 May 2021 12:51:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1994075pjv.1
        for <linux-scsi@vger.kernel.org>; Tue, 11 May 2021 12:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4/kB/opilV47Yf2HH9a7oVggvd5yLkg6gauhp1kNfY=;
        b=f8hp+4IYz3xD4i8cD7lm8T6lmYCcrrgeo8IAHbyVLxuAZXHe9vyHCzRhcitrjDeLBZ
         O9uaTMubYKDKeJHaKH10trU5+w6PdhauBQAAxkeE7wsnvD5n51tL/slp8FjmyhqpTjqg
         agxxp7S6MZFxvCy+DNcnwCu2UxDZ0qerWE9nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4/kB/opilV47Yf2HH9a7oVggvd5yLkg6gauhp1kNfY=;
        b=kwQtDhL2TELfPpugEclyEprHa024ItaY+qs8Qt2HcoLoc9auDigxbmN/O9AvZ7bKA8
         oqPKzj58qG8lCSVeCepxivEa3W+ZS5iSzCDb/S24uzCpGu3+XwFk3PlADZ7Z4MbWNAKx
         41UT4jYPG6OtDrI37kmOvp/kXddkXbDZXG40FjNIUrZmPKKAq+I8DD0+gA2Bdz/XhYHv
         iSiQhirjnr9FRZriXfzi27KL8smSldXBfIVDsZF3aoc7clO63crvjJjhowr2MXX231kF
         R3b7mG1P0RYgwmCAbdGYSOZOiaMFxpF2zml/j9hjnBIW8LRJ46pWuzILa4+VgZ8uaFFC
         cvEg==
X-Gm-Message-State: AOAM532MbCg5F8VUNnskyn9n/WE9EQq1sdBkcZ79uYS27RrPug/One+X
        9Wl/ohRYsZkHfbCPIvtrKMF+3KAJLL1VGU04uzRQNEs1OO4iMkE4R4DfPQZxlSDmSNFas/S31gI
        hAw7c8EEUguEYUF35f7du58jj69XKt8p01PPUvdGFJk34g5ZNOfTo7Mj97XaqzQPMzyO0acyb7Z
        8hTrhKRQ==
X-Google-Smtp-Source: ABdhPJy0SEiLsvUVekgBsEAZcnAjMOiszU74vzX5kYkTradBxTX/N+8p8IdmGbHVCNPNAss9asvGIg==
X-Received: by 2002:a17:90a:fb98:: with SMTP id cp24mr34668359pjb.24.1620762688902;
        Tue, 11 May 2021 12:51:28 -0700 (PDT)
Received: from drv-bst-rhel8.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id b3sm6317581pfv.61.2021.05.11.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:51:28 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        steve.hagan@broadcom.com, peter.rivera@broadcom.com,
        mpi3mr-linuxdrv.pdl@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        sathya.prakash@broadcom.com
Subject: [PATCH v4 06/24] mpi3mr: add support of event handling part-1
Date:   Wed, 12 May 2021 01:24:05 +0530
Message-Id: <20210511195423.2134562-7-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210511195423.2134562-1-kashyap.desai@broadcom.com>
References: <20210511195423.2134562-1-kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007e085905c2133864"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000007e085905c2133864

Firmware can report various MPI Events.
Support for certain Events (as listed below) are enabled in the driver
and their processing in driver is covered in this patch.

MPI3_EVENT_DEVICE_ADDED
MPI3_EVENT_DEVICE_INFO_CHANGED
MPI3_EVENT_DEVICE_STATUS_CHANGE
MPI3_EVENT_ENCL_DEVICE_STATUS_CHANGE
MPI3_EVENT_SAS_TOPOLOGY_CHANGE_LIST
MPI3_EVENT_SAS_DISCOVERY
MPI3_EVENT_SAS_DEVICE_DISCOVERY_ERROR

Key support in this patch is device add/removal.

Fix some compilation warning reported by kernel test robot.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

Cc: sathya.prakash@broadcom.com
---
 drivers/scsi/mpi3mr/mpi/mpi30_api.h  |    2 +
 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h | 1884 ++++++++++++++++++++++++++
 drivers/scsi/mpi3mr/mpi/mpi30_sas.h  |   37 +
 drivers/scsi/mpi3mr/mpi3mr.h         |  202 +++
 drivers/scsi/mpi3mr/mpi3mr_fw.c      |  197 ++-
 drivers/scsi/mpi3mr/mpi3mr_os.c      | 1457 +++++++++++++++++++-
 6 files changed, 3776 insertions(+), 3 deletions(-)
 create mode 100644 drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
 create mode 100644 drivers/scsi/mpi3mr/mpi/mpi30_sas.h

diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_api.h b/drivers/scsi/mpi3mr/mpi/mpi30_api.h
index 48247c254953..aa1de696be6b 100644
--- a/drivers/scsi/mpi3mr/mpi/mpi30_api.h
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_api.h
@@ -12,7 +12,9 @@
 #ifndef MPI30_API_H
 #define MPI30_API_H     1
 #include "mpi30_transport.h"
+#include "mpi30_cnfg.h"
 #include "mpi30_image.h"
 #include "mpi30_init.h"
 #include "mpi30_ioc.h"
+#include "mpi30_sas.h"
 #endif
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
new file mode 100644
index 000000000000..0133ee7017b7
--- /dev/null
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_cnfg.h
@@ -0,0 +1,1884 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright 2017-2021 Broadcom Inc. All rights reserved.
+ *
+ *           Name: mpi30_cnfg.h
+ *    Description: Contains definitions for Configuration messages and pages
+ *  Creation Date: 03/15/2017
+ *        Version: 03.00.00
+ */
+#ifndef MPI30_CNFG_H
+#define MPI30_CNFG_H     1
+#define MPI3_CONFIG_PAGETYPE_IO_UNIT                    (0x00)
+#define MPI3_CONFIG_PAGETYPE_MANUFACTURING              (0x01)
+#define MPI3_CONFIG_PAGETYPE_IOC                        (0x02)
+#define MPI3_CONFIG_PAGETYPE_UEFI_BSD                   (0x03)
+#define MPI3_CONFIG_PAGETYPE_SECURITY                   (0x04)
+#define MPI3_CONFIG_PAGETYPE_ENCLOSURE                  (0x11)
+#define MPI3_CONFIG_PAGETYPE_DEVICE                     (0x12)
+#define MPI3_CONFIG_PAGETYPE_SAS_IO_UNIT                (0x20)
+#define MPI3_CONFIG_PAGETYPE_SAS_EXPANDER               (0x21)
+#define MPI3_CONFIG_PAGETYPE_SAS_PHY                    (0x23)
+#define MPI3_CONFIG_PAGETYPE_SAS_PORT                   (0x24)
+#define MPI3_CONFIG_PAGETYPE_PCIE_IO_UNIT               (0x30)
+#define MPI3_CONFIG_PAGETYPE_PCIE_SWITCH                (0x31)
+#define MPI3_CONFIG_PAGETYPE_PCIE_LINK                  (0x33)
+#define MPI3_CONFIG_PAGEATTR_MASK                       (0xf0)
+#define MPI3_CONFIG_PAGEATTR_READ_ONLY                  (0x00)
+#define MPI3_CONFIG_PAGEATTR_CHANGEABLE                 (0x10)
+#define MPI3_CONFIG_PAGEATTR_PERSISTENT                 (0x20)
+#define MPI3_CONFIG_ACTION_PAGE_HEADER                  (0x00)
+#define MPI3_CONFIG_ACTION_READ_DEFAULT                 (0x01)
+#define MPI3_CONFIG_ACTION_READ_CURRENT                 (0x02)
+#define MPI3_CONFIG_ACTION_WRITE_CURRENT                (0x03)
+#define MPI3_CONFIG_ACTION_READ_PERSISTENT              (0x04)
+#define MPI3_CONFIG_ACTION_WRITE_PERSISTENT             (0x05)
+#define MPI3_DEVICE_PGAD_FORM_MASK                      (0xf0000000)
+#define MPI3_DEVICE_PGAD_FORM_GET_NEXT_HANDLE           (0x00000000)
+#define MPI3_DEVICE_PGAD_FORM_HANDLE                    (0x20000000)
+#define MPI3_DEVICE_PGAD_HANDLE_MASK                    (0x0000ffff)
+#define MPI3_SAS_EXPAND_PGAD_FORM_MASK                  (0xf0000000)
+#define MPI3_SAS_EXPAND_PGAD_FORM_GET_NEXT_HANDLE       (0x00000000)
+#define MPI3_SAS_EXPAND_PGAD_FORM_HANDLE_PHY_NUM        (0x10000000)
+#define MPI3_SAS_EXPAND_PGAD_FORM_HANDLE                (0x20000000)
+#define MPI3_SAS_EXPAND_PGAD_PHYNUM_MASK                (0x00ff0000)
+#define MPI3_SAS_EXPAND_PGAD_PHYNUM_SHIFT               (16)
+#define MPI3_SAS_EXPAND_PGAD_HANDLE_MASK                (0x0000ffff)
+#define MPI3_SAS_PHY_PGAD_FORM_MASK                     (0xf0000000)
+#define MPI3_SAS_PHY_PGAD_FORM_PHY_NUMBER               (0x00000000)
+#define MPI3_SAS_PHY_PGAD_PHY_NUMBER_MASK               (0x000000ff)
+#define MPI3_SASPORT_PGAD_FORM_MASK                     (0xf0000000)
+#define MPI3_SASPORT_PGAD_FORM_GET_NEXT_PORT            (0x00000000)
+#define MPI3_SASPORT_PGAD_FORM_PORT_NUM                 (0x10000000)
+#define MPI3_SASPORT_PGAD_PORT_NUMBER_MASK              (0x000000ff)
+#define MPI3_ENCLOS_PGAD_FORM_MASK                      (0xf0000000)
+#define MPI3_ENCLOS_PGAD_FORM_GET_NEXT_HANDLE           (0x00000000)
+#define MPI3_ENCLOS_PGAD_FORM_HANDLE                    (0x10000000)
+#define MPI3_ENCLOS_PGAD_HANDLE_MASK                    (0x0000ffff)
+#define MPI3_PCIE_SWITCH_PGAD_FORM_MASK                 (0xf0000000)
+#define MPI3_PCIE_SWITCH_PGAD_FORM_GET_NEXT_HANDLE      (0x00000000)
+#define MPI3_PCIE_SWITCH_PGAD_FORM_HANDLE_PORT_NUM      (0x10000000)
+#define MPI3_PCIE_SWITCH_PGAD_FORM_HANDLE               (0x20000000)
+#define MPI3_PCIE_SWITCH_PGAD_PORTNUM_MASK              (0x00ff0000)
+#define MPI3_PCIE_SWITCH_PGAD_PORTNUM_SHIFT             (16)
+#define MPI3_PCIE_SWITCH_PGAD_HANDLE_MASK               (0x0000ffff)
+#define MPI3_PCIE_LINK_PGAD_FORM_MASK                   (0xf0000000)
+#define MPI3_PCIE_LINK_PGAD_FORM_GET_NEXT_LINK          (0x00000000)
+#define MPI3_PCIE_LINK_PGAD_FORM_LINK_NUM               (0x10000000)
+#define MPI3_PCIE_LINK_PGAD_LINKNUM_MASK                (0x000000ff)
+#define MPI3_SECURITY_PGAD_FORM_MASK                    (0xf0000000)
+#define MPI3_SECURITY_PGAD_FORM_GET_NEXT_SLOT           (0x00000000)
+#define MPI3_SECURITY_PGAD_FORM_SOT_NUM                 (0x10000000)
+#define MPI3_SECURITY_PGAD_SLOT_GROUP_MASK              (0x0000ff00)
+#define MPI3_SECURITY_PGAD_SLOT_MASK                    (0x000000ff)
+struct _mpi3_config_request {
+	__le16             host_tag;
+	u8                 ioc_use_only02;
+	u8                 function;
+	__le16             ioc_use_only04;
+	u8                 ioc_use_only06;
+	u8                 msg_flags;
+	__le16             change_count;
+	__le16             reserved0a;
+	u8                 page_version;
+	u8                 page_number;
+	u8                 page_type;
+	u8                 action;
+	__le32             page_address;
+	__le16             page_length;
+	__le16             reserved16;
+	__le32             reserved18[2];
+	union _mpi3_sge_union  sgl;
+};
+
+struct _mpi3_config_page_header {
+	u8                 page_version;
+	u8                 reserved01;
+	u8                 page_number;
+	u8                 page_attribute;
+	__le16             page_length;
+	u8                 page_type;
+	u8                 reserved07;
+};
+
+#define MPI3_SAS_NEG_LINK_RATE_LOGICAL_MASK             (0xf0)
+#define MPI3_SAS_NEG_LINK_RATE_LOGICAL_SHIFT            (4)
+#define MPI3_SAS_NEG_LINK_RATE_PHYSICAL_MASK            (0x0f)
+#define MPI3_SAS_NEG_LINK_RATE_UNKNOWN_LINK_RATE        (0x00)
+#define MPI3_SAS_NEG_LINK_RATE_PHY_DISABLED             (0x01)
+#define MPI3_SAS_NEG_LINK_RATE_NEGOTIATION_FAILED       (0x02)
+#define MPI3_SAS_NEG_LINK_RATE_SATA_OOB_COMPLETE        (0x03)
+#define MPI3_SAS_NEG_LINK_RATE_PORT_SELECTOR            (0x04)
+#define MPI3_SAS_NEG_LINK_RATE_SMP_RESET_IN_PROGRESS    (0x05)
+#define MPI3_SAS_NEG_LINK_RATE_UNSUPPORTED_PHY          (0x06)
+#define MPI3_SAS_NEG_LINK_RATE_1_5                      (0x08)
+#define MPI3_SAS_NEG_LINK_RATE_3_0                      (0x09)
+#define MPI3_SAS_NEG_LINK_RATE_6_0                      (0x0a)
+#define MPI3_SAS_NEG_LINK_RATE_12_0                     (0x0b)
+#define MPI3_SAS_NEG_LINK_RATE_22_5                     (0x0c)
+#define MPI3_SAS_APHYINFO_INSIDE_ZPSDS_PERSISTENT       (0x00000040)
+#define MPI3_SAS_APHYINFO_REQUESTED_INSIDE_ZPSDS        (0x00000020)
+#define MPI3_SAS_APHYINFO_BREAK_REPLY_CAPABLE           (0x00000010)
+#define MPI3_SAS_APHYINFO_REASON_MASK                   (0x0000000f)
+#define MPI3_SAS_APHYINFO_REASON_UNKNOWN                (0x00000000)
+#define MPI3_SAS_APHYINFO_REASON_POWER_ON               (0x00000001)
+#define MPI3_SAS_APHYINFO_REASON_HARD_RESET             (0x00000002)
+#define MPI3_SAS_APHYINFO_REASON_SMP_PHY_CONTROL        (0x00000003)
+#define MPI3_SAS_APHYINFO_REASON_LOSS_OF_SYNC           (0x00000004)
+#define MPI3_SAS_APHYINFO_REASON_MULTIPLEXING_SEQ       (0x00000005)
+#define MPI3_SAS_APHYINFO_REASON_IT_NEXUS_LOSS_TIMER    (0x00000006)
+#define MPI3_SAS_APHYINFO_REASON_BREAK_TIMEOUT          (0x00000007)
+#define MPI3_SAS_APHYINFO_REASON_PHY_TEST_STOPPED       (0x00000008)
+#define MPI3_SAS_APHYINFO_REASON_EXP_REDUCED_FUNC       (0x00000009)
+#define MPI3_SAS_PHYINFO_STATUS_MASK                    (0xc0000000)
+#define MPI3_SAS_PHYINFO_STATUS_SHIFT                   (30)
+#define MPI3_SAS_PHYINFO_STATUS_ACCESSIBLE              (0x00000000)
+#define MPI3_SAS_PHYINFO_STATUS_NOT_EXIST               (0x40000000)
+#define MPI3_SAS_PHYINFO_STATUS_VACANT                  (0x80000000)
+#define MPI3_SAS_PHYINFO_PHY_POWER_CONDITION_MASK       (0x18000000)
+#define MPI3_SAS_PHYINFO_PHY_POWER_CONDITION_ACTIVE     (0x00000000)
+#define MPI3_SAS_PHYINFO_PHY_POWER_CONDITION_PARTIAL    (0x08000000)
+#define MPI3_SAS_PHYINFO_PHY_POWER_CONDITION_SLUMBER    (0x10000000)
+#define MPI3_SAS_PHYINFO_REASON_MASK                    (0x000f0000)
+#define MPI3_SAS_PHYINFO_REASON_UNKNOWN                 (0x00000000)
+#define MPI3_SAS_PHYINFO_REASON_POWER_ON                (0x00010000)
+#define MPI3_SAS_PHYINFO_REASON_HARD_RESET              (0x00020000)
+#define MPI3_SAS_PHYINFO_REASON_SMP_PHY_CONTROL         (0x00030000)
+#define MPI3_SAS_PHYINFO_REASON_LOSS_OF_SYNC            (0x00040000)
+#define MPI3_SAS_PHYINFO_REASON_MULTIPLEXING_SEQ        (0x00050000)
+#define MPI3_SAS_PHYINFO_REASON_IT_NEXUS_LOSS_TIMER     (0x00060000)
+#define MPI3_SAS_PHYINFO_REASON_BREAK_TIMEOUT           (0x00070000)
+#define MPI3_SAS_PHYINFO_REASON_PHY_TEST_STOPPED        (0x00080000)
+#define MPI3_SAS_PHYINFO_REASON_EXP_REDUCED_FUNC        (0x00090000)
+#define MPI3_SAS_PHYINFO_SATA_PORT_ACTIVE               (0x00004000)
+#define MPI3_SAS_PHYINFO_SATA_PORT_SELECTOR_PRESENT     (0x00002000)
+#define MPI3_SAS_PHYINFO_VIRTUAL_PHY                    (0x00001000)
+#define MPI3_SAS_PHYINFO_PARTIAL_PATHWAY_TIME_MASK      (0x00000f00)
+#define MPI3_SAS_PHYINFO_PARTIAL_PATHWAY_TIME_SHIFT     (8)
+#define MPI3_SAS_PHYINFO_ROUTING_ATTRIBUTE_MASK         (0x000000f0)
+#define MPI3_SAS_PHYINFO_ROUTING_ATTRIBUTE_DIRECT       (0x00000000)
+#define MPI3_SAS_PHYINFO_ROUTING_ATTRIBUTE_SUBTRACTIVE  (0x00000010)
+#define MPI3_SAS_PHYINFO_ROUTING_ATTRIBUTE_TABLE        (0x00000020)
+#define MPI3_SAS_PRATE_MAX_RATE_MASK                    (0xf0)
+#define MPI3_SAS_PRATE_MAX_RATE_NOT_PROGRAMMABLE        (0x00)
+#define MPI3_SAS_PRATE_MAX_RATE_1_5                     (0x80)
+#define MPI3_SAS_PRATE_MAX_RATE_3_0                     (0x90)
+#define MPI3_SAS_PRATE_MAX_RATE_6_0                     (0xa0)
+#define MPI3_SAS_PRATE_MAX_RATE_12_0                    (0xb0)
+#define MPI3_SAS_PRATE_MAX_RATE_22_5                    (0xc0)
+#define MPI3_SAS_PRATE_MIN_RATE_MASK                    (0x0f)
+#define MPI3_SAS_PRATE_MIN_RATE_NOT_PROGRAMMABLE        (0x00)
+#define MPI3_SAS_PRATE_MIN_RATE_1_5                     (0x08)
+#define MPI3_SAS_PRATE_MIN_RATE_3_0                     (0x09)
+#define MPI3_SAS_PRATE_MIN_RATE_6_0                     (0x0a)
+#define MPI3_SAS_PRATE_MIN_RATE_12_0                    (0x0b)
+#define MPI3_SAS_PRATE_MIN_RATE_22_5                    (0x0c)
+#define MPI3_SAS_HWRATE_MAX_RATE_MASK                   (0xf0)
+#define MPI3_SAS_HWRATE_MAX_RATE_1_5                    (0x80)
+#define MPI3_SAS_HWRATE_MAX_RATE_3_0                    (0x90)
+#define MPI3_SAS_HWRATE_MAX_RATE_6_0                    (0xa0)
+#define MPI3_SAS_HWRATE_MAX_RATE_12_0                   (0xb0)
+#define MPI3_SAS_HWRATE_MAX_RATE_22_5                   (0xc0)
+#define MPI3_SAS_HWRATE_MIN_RATE_MASK                   (0x0f)
+#define MPI3_SAS_HWRATE_MIN_RATE_1_5                    (0x08)
+#define MPI3_SAS_HWRATE_MIN_RATE_3_0                    (0x09)
+#define MPI3_SAS_HWRATE_MIN_RATE_6_0                    (0x0a)
+#define MPI3_SAS_HWRATE_MIN_RATE_12_0                   (0x0b)
+#define MPI3_SAS_HWRATE_MIN_RATE_22_5                   (0x0c)
+#define MPI3_SLOT_INVALID                           (0xffff)
+#define MPI3_SLOT_INDEX_INVALID                     (0xffff)
+struct _mpi3_man_page0 {
+	struct _mpi3_config_page_header         header;
+	u8                                 chip_revision[8];
+	u8                                 chip_name[32];
+	u8                                 board_name[32];
+	u8                                 board_assembly[32];
+	u8                                 board_tracer_number[32];
+	__le32                             board_power;
+	__le32                             reserved94;
+	__le32                             reserved98;
+	u8                                 oem;
+	u8                                 sub_oem;
+	__le16                             reserved9e;
+	u8                                 board_mfg_day;
+	u8                                 board_mfg_month;
+	__le16                             board_mfg_year;
+	u8                                 board_rework_day;
+	u8                                 board_rework_month;
+	__le16                             board_rework_year;
+	__le64                             board_revision;
+	u8                                 e_pack_fru[16];
+	u8                                 product_name[256];
+};
+
+#define MPI3_MAN0_PAGEVERSION       (0x00)
+#define MPI3_MAN1_VPD_SIZE                                   (512)
+struct _mpi3_man_page1 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08[2];
+	u8                                 vpd[MPI3_MAN1_VPD_SIZE];
+};
+
+#define MPI3_MAN1_PAGEVERSION                                 (0x00)
+struct _mpi3_man5_phy_entry {
+	__le64     ioc_wwid;
+	__le64     device_name;
+	__le64     sata_wwid;
+};
+
+#ifndef MPI3_MAN5_PHY_MAX
+#define MPI3_MAN5_PHY_MAX                                   (1)
+#endif
+struct _mpi3_man_page5 {
+	struct _mpi3_config_page_header         header;
+	u8                                 num_phys;
+	u8                                 reserved09[3];
+	__le32                             reserved0c;
+	struct _mpi3_man5_phy_entry             phy[MPI3_MAN5_PHY_MAX];
+};
+
+#define MPI3_MAN5_PAGEVERSION                                (0x00)
+struct _mpi3_man6_gpio_entry {
+	u8         function_code;
+	u8         reserved01;
+	__le16     flags;
+	u8         param1;
+	u8         param2;
+	__le16     reserved06;
+	__le32     param3;
+};
+
+#define MPI3_MAN6_GPIO_FUNCTION_GENERIC                                       (0x00)
+#define MPI3_MAN6_GPIO_FUNCTION_ALTERNATE                                     (0x01)
+#define MPI3_MAN6_GPIO_FUNCTION_EXT_INTERRUPT                                 (0x02)
+#define MPI3_MAN6_GPIO_FUNCTION_GLOBAL_ACTIVITY                               (0x03)
+#define MPI3_MAN6_GPIO_FUNCTION_OVER_TEMPERATURE                              (0x04)
+#define MPI3_MAN6_GPIO_FUNCTION_PORT_STATUS_GREEN                             (0x05)
+#define MPI3_MAN6_GPIO_FUNCTION_PORT_STATUS_YELLOW                            (0x06)
+#define MPI3_MAN6_GPIO_FUNCTION_CABLE_MANAGEMENT                              (0x07)
+#define MPI3_MAN6_GPIO_FUNCTION_BKPLANE_MGMT_TYPE                             (0x08)
+#define MPI3_MAN6_GPIO_FUNCTION_ISTWI_MUX_RESET                               (0x09)
+#define MPI3_MAN6_GPIO_FUNCTION_ISTWI_RESET                                   (0x0a)
+#define MPI3_MAN6_GPIO_FUNCTION_BACKEND_PCIE_RESET                            (0x0b)
+#define MPI3_MAN6_GPIO_FUNCTION_GLOBAL_FAULT                                  (0x0c)
+#define MPI3_MAN6_GPIO_FUNCTION_EPACK_ATTN                                    (0x0d)
+#define MPI3_MAN6_GPIO_FUNCTION_EPACK_ONLINE                                  (0x0e)
+#define MPI3_MAN6_GPIO_FUNCTION_EPACK_FAULT                                   (0x0f)
+#define MPI3_MAN6_GPIO_FUNCTION_CTRL_TYPE                                     (0x10)
+#define MPI3_MAN6_GPIO_FUNCTION_LICENSE                                       (0x11)
+#define MPI3_MAN6_GPIO_FUNCTION_REFCLK_CONTROL                                (0x12)
+#define MPI3_MAN6_GPIO_EXTINT_PARAM1_FLAGS_SOURCE_MASK                        (0xf0)
+#define MPI3_MAN6_GPIO_EXTINT_PARAM1_FLAGS_SOURCE_GENERIC                     (0x00)
+#define MPI3_MAN6_GPIO_EXTINT_PARAM1_FLAGS_SOURCE_CABLE_MGMT                  (0x10)
+#define MPI3_MAN6_GPIO_EXTINT_PARAM1_FLAGS_SOURCE_ACTIVE_CABLE_OVERCURRENT    (0x20)
+#define MPI3_MAN6_GPIO_EXTINT_PARAM1_FLAGS_TRIGGER_MASK                       (0x01)
+#define MPI3_MAN6_GPIO_EXTINT_PARAM1_FLAGS_TRIGGER_EDGE                       (0x00)
+#define MPI3_MAN6_GPIO_EXTINT_PARAM1_FLAGS_TRIGGER_LEVEL                      (0x01)
+#define MPI3_MAN6_GPIO_PORT_GREEN_PARAM1_PHY_STATUS_ALL_UP                    (0x00)
+#define MPI3_MAN6_GPIO_PORT_GREEN_PARAM1_PHY_STATUS_ONE_OR_MORE_UP            (0x01)
+#define MPI3_MAN6_GPIO_CABLE_MGMT_PARAM1_INTERFACE_MODULE_PRESENT             (0x00)
+#define MPI3_MAN6_GPIO_CABLE_MGMT_PARAM1_INTERFACE_ACTIVE_CABLE_ENABLE        (0x01)
+#define MPI3_MAN6_GPIO_CABLE_MGMT_PARAM1_INTERFACE_CABLE_MGMT_ENABLE          (0x02)
+#define MPI3_MAN6_GPIO_ISTWI_MUX_RESET_PARAM2_SPEC_MUX                        (0x00)
+#define MPI3_MAN6_GPIO_ISTWI_MUX_RESET_PARAM2_ALL_MUXES                       (0x01)
+#define MPI3_MAN6_GPIO_LICENSE_PARAM1_TYPE_IBUTTON                            (0x00)
+#define MPI3_MAN6_GPIO_FLAGS_SLEW_RATE_MASK                                   (0x0100)
+#define MPI3_MAN6_GPIO_FLAGS_SLEW_RATE_FAST_EDGE                              (0x0100)
+#define MPI3_MAN6_GPIO_FLAGS_SLEW_RATE_SLOW_EDGE                              (0x0000)
+#define MPI3_MAN6_GPIO_FLAGS_DRIVE_STRENGTH_MASK                              (0x00c0)
+#define MPI3_MAN6_GPIO_FLAGS_DRIVE_STRENGTH_100OHM                            (0x0000)
+#define MPI3_MAN6_GPIO_FLAGS_DRIVE_STRENGTH_66OHM                             (0x0040)
+#define MPI3_MAN6_GPIO_FLAGS_DRIVE_STRENGTH_50OHM                             (0x0080)
+#define MPI3_MAN6_GPIO_FLAGS_DRIVE_STRENGTH_33OHM                             (0x00c0)
+#define MPI3_MAN6_GPIO_FLAGS_ALT_DATA_SEL_MASK                                (0x0030)
+#define MPI3_MAN6_GPIO_FLAGS_ALT_DATA_SEL_SHIFT                               (4)
+#define MPI3_MAN6_GPIO_FLAGS_ACTIVE_HIGH                                      (0x0008)
+#define MPI3_MAN6_GPIO_FLAGS_BI_DIR_ENABLED                                   (0x0004)
+#define MPI3_MAN6_GPIO_FLAGS_DIRECTION_MASK                                   (0x0003)
+#define MPI3_MAN6_GPIO_FLAGS_DIRECTION_INPUT                                  (0x0000)
+#define MPI3_MAN6_GPIO_FLAGS_DIRECTION_OPEN_DRAIN_OUTPUT                      (0x0001)
+#define MPI3_MAN6_GPIO_FLAGS_DIRECTION_OPEN_SOURCE_OUTPUT                     (0x0002)
+#define MPI3_MAN6_GPIO_FLAGS_DIRECTION_PUSH_PULL_OUTPUT                       (0x0003)
+#ifndef MPI3_MAN6_GPIO_MAX
+#define MPI3_MAN6_GPIO_MAX                                                    (1)
+#endif
+struct _mpi3_man_page6 {
+	struct _mpi3_config_page_header         header;
+	__le16                             flags;
+	__le16                             reserved0a;
+	u8                                 num_gpio;
+	u8                                 reserved0d[3];
+	struct _mpi3_man6_gpio_entry            gpio[MPI3_MAN6_GPIO_MAX];
+};
+
+#define MPI3_MAN6_PAGEVERSION                                                 (0x00)
+#define MPI3_MAN6_FLAGS_HEARTBEAT_LED_DISABLED                                (0x0001)
+struct _mpi3_man7_receptacle_info {
+	__le32                             name[4];
+	u8                                 location;
+	u8                                 connector_type;
+	u8                                 ped_clk;
+	u8                                 connector_id;
+	__le32                             reserved14;
+};
+
+#define MPI3_MAN7_LOCATION_UNKNOWN                         (0x00)
+#define MPI3_MAN7_LOCATION_INTERNAL                        (0x01)
+#define MPI3_MAN7_LOCATION_EXTERNAL                        (0x02)
+#define MPI3_MAN7_LOCATION_VIRTUAL                         (0x03)
+#define MPI3_MAN7_PEDCLK_ROUTING_MASK                      (0x10)
+#define MPI3_MAN7_PEDCLK_ROUTING_DIRECT                    (0x00)
+#define MPI3_MAN7_PEDCLK_ROUTING_CLOCK_BUFFER              (0x10)
+#define MPI3_MAN7_PEDCLK_ID_MASK                           (0x0f)
+#ifndef MPI3_MAN7_RECEPTACLE_INFO_MAX
+#define MPI3_MAN7_RECEPTACLE_INFO_MAX                      (1)
+#endif
+struct _mpi3_man_page7 {
+	struct _mpi3_config_page_header         header;
+	__le32                             flags;
+	u8                                 num_receptacles;
+	u8                                 reserved0d[3];
+	__le32                             enclosure_name[4];
+	struct _mpi3_man7_receptacle_info       receptacle_info[MPI3_MAN7_RECEPTACLE_INFO_MAX];
+};
+
+#define MPI3_MAN7_PAGEVERSION                              (0x00)
+#define MPI3_MAN7_FLAGS_BASE_ENCLOSURE_LEVEL_MASK          (0x01)
+#define MPI3_MAN7_FLAGS_BASE_ENCLOSURE_LEVEL_0             (0x00)
+#define MPI3_MAN7_FLAGS_BASE_ENCLOSURE_LEVEL_1             (0x01)
+struct _mpi3_man8_phy_info {
+	u8                                 receptacle_id;
+	u8                                 connector_lane;
+	__le16                             reserved02;
+	__le16                             slotx1;
+	__le16                             slotx2;
+	__le16                             slotx4;
+	__le16                             reserved0a;
+	__le32                             reserved0c;
+};
+
+#ifndef MPI3_MAN8_PHY_INFO_MAX
+#define MPI3_MAN8_PHY_INFO_MAX                      (1)
+#endif
+struct _mpi3_man_page8 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_phys;
+	u8                                 reserved0d[3];
+	struct _mpi3_man8_phy_info              phy_info[MPI3_MAN8_PHY_INFO_MAX];
+};
+
+#define MPI3_MAN8_PAGEVERSION                   (0x00)
+struct _mpi3_man9_rsrc_entry {
+	__le32     maximum;
+	__le32     decrement;
+	__le32     minimum;
+	__le32     actual;
+};
+
+enum mpi3_man9_resources {
+	MPI3_MAN9_RSRC_OUTSTANDING_REQS = 0,
+	MPI3_MAN9_RSRC_TARGET_CMDS      = 1,
+	MPI3_MAN9_RSRC_SAS_TARGETS      = 2,
+	MPI3_MAN9_RSRC_PCIE_TARGETS     = 3,
+	MPI3_MAN9_RSRC_INITIATORS       = 4,
+	MPI3_MAN9_RSRC_VDS              = 5,
+	MPI3_MAN9_RSRC_ENCLOSURES       = 6,
+	MPI3_MAN9_RSRC_ENCLOSURE_PHYS   = 7,
+	MPI3_MAN9_RSRC_EXPANDERS        = 8,
+	MPI3_MAN9_RSRC_PCIE_SWITCHES    = 9,
+	MPI3_MAN9_RSRC_PDS              = 10,
+	MPI3_MAN9_RSRC_HOST_PDS         = 11,
+	MPI3_MAN9_RSRC_ADV_HOST_PDS     = 12,
+	MPI3_MAN9_RSRC_RAID_PDS         = 13,
+	MPI3_MAN9_RSRC_NUM_RESOURCES
+};
+
+#define MPI3_MAN9_MIN_OUTSTANDING_REQS      (1)
+#define MPI3_MAN9_MAX_OUTSTANDING_REQS      (65000)
+#define MPI3_MAN9_MIN_TARGET_CMDS           (0)
+#define MPI3_MAN9_MAX_TARGET_CMDS           (65535)
+#define MPI3_MAN9_MIN_SAS_TARGETS           (0)
+#define MPI3_MAN9_MAX_SAS_TARGETS           (65535)
+#define MPI3_MAN9_MIN_PCIE_TARGETS          (0)
+#define MPI3_MAN9_MIN_INITIATORS            (0)
+#define MPI3_MAN9_MAX_INITIATORS            (65535)
+#define MPI3_MAN9_MIN_ENCLOSURES            (0)
+#define MPI3_MAN9_MAX_ENCLOSURES            (65535)
+#define MPI3_MAN9_MIN_ENCLOSURE_PHYS        (0)
+#define MPI3_MAN9_MIN_EXPANDERS             (0)
+#define MPI3_MAN9_MAX_EXPANDERS             (65535)
+#define MPI3_MAN9_MIN_PCIE_SWITCHES         (0)
+struct _mpi3_man_page9 {
+	struct _mpi3_config_page_header         header;
+	u8                                 num_resources;
+	u8                                 reserved09;
+	__le16                             reserved0a;
+	__le32                             reserved0c;
+	__le32                             reserved10;
+	__le32                             reserved14;
+	__le32                             reserved18;
+	__le32                             reserved1c;
+	struct _mpi3_man9_rsrc_entry            resource[mpi3_man9_rsrc_num_resources];
+};
+
+#define MPI3_MAN9_PAGEVERSION                   (0x00)
+struct _mpi3_man10_istwi_ctrlr_entry {
+	__le16     slave_address;
+	__le16     flags;
+	__le32     reserved04;
+};
+
+#define MPI3_MAN10_ISTWI_CTRLR_FLAGS_SLAVE_ENABLED          (0x0002)
+#define MPI3_MAN10_ISTWI_CTRLR_FLAGS_MASTER_ENABLED         (0x0001)
+#ifndef MPI3_MAN10_ISTWI_CTRLR_MAX
+#define MPI3_MAN10_ISTWI_CTRLR_MAX          (1)
+#endif
+struct _mpi3_man_page10 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_istwi_ctrl;
+	u8                                 reserved0d[3];
+	struct _mpi3_man10_istwi_ctrlr_entry    istwi_controller[MPI3_MAN10_ISTWI_CTRLR_MAX];
+};
+
+#define MPI3_MAN10_PAGEVERSION                  (0x00)
+struct _mpi3_man11_mux_device_format {
+	u8         max_channel;
+	u8         reserved01[3];
+	__le32     reserved04;
+};
+
+struct _mpi3_man11_temp_sensor_device_format {
+	u8         type;
+	u8         reserved01[3];
+	u8         temp_channel[4];
+};
+
+#define MPI3_MAN11_TEMP_SENSOR_TYPE_MAX6654         (0x00)
+#define MPI3_MAN11_TEMP_SENSOR_TYPE_EMC1442         (0x01)
+#define MPI3_MAN11_TEMP_SENSOR_TYPE_ADT7476         (0x02)
+#define MPI3_MAN11_TEMP_SENSOR_CHANNEL_ENABLED      (0x01)
+struct _mpi3_man11_seeprom_device_format {
+	u8         size;
+	u8         page_write_size;
+	__le16     reserved02;
+	__le32     reserved04;
+};
+
+#define MPI3_MAN11_SEEPROM_SIZE_1KBITS              (0x01)
+#define MPI3_MAN11_SEEPROM_SIZE_2KBITS              (0x02)
+#define MPI3_MAN11_SEEPROM_SIZE_4KBITS              (0x03)
+#define MPI3_MAN11_SEEPROM_SIZE_8KBITS              (0x04)
+#define MPI3_MAN11_SEEPROM_SIZE_16KBITS             (0x05)
+#define MPI3_MAN11_SEEPROM_SIZE_32KBITS             (0x06)
+#define MPI3_MAN11_SEEPROM_SIZE_64KBITS             (0x07)
+#define MPI3_MAN11_SEEPROM_SIZE_128KBITS            (0x08)
+struct _mpi3_man11_ddr_spd_device_format {
+	u8         channel;
+	u8         reserved01[3];
+	__le32     reserved04;
+};
+
+struct _mpi3_man11_cable_mgmt_device_format {
+	u8         type;
+	u8         receptacle_id;
+	__le16     reserved02;
+	__le32     reserved04;
+};
+
+#define MPI3_MAN11_CABLE_MGMT_TYPE_SFF_8636           (0x00)
+struct _mpi3_man11_bkplane_spec_ubm_format {
+	__le16     flags;
+	__le16     reserved02;
+};
+
+#define MPI3_MAN11_BKPLANE_UBM_FLAGS_REFCLK_POLICY_ALWAYS_ENABLED  (0x0200)
+#define MPI3_MAN11_BKPLANE_UBM_FLAGS_FORCE_POLLING                 (0x0100)
+#define MPI3_MAN11_BKPLANE_UBM_FLAGS_MAX_FRU_MASK                  (0x00f0)
+#define MPI3_MAN11_BKPLANE_UBM_FLAGS_MAX_FRU_SHIFT                 (4)
+#define MPI3_MAN11_BKPLANE_UBM_FLAGS_POLL_INTERVAL_MASK            (0x000f)
+#define MPI3_MAN11_BKPLANE_UBM_FLAGS_POLL_INTERVAL_SHIFT           (0)
+struct _mpi3_man11_bkplane_spec_vpp_format {
+	__le16     flags;
+	__le16     reserved02;
+};
+
+#define MPI3_MAN11_BKPLANE_VPP_FLAGS_REFCLK_POLICY_ALWAYS_ENABLED  (0x0040)
+#define MPI3_MAN11_BKPLANE_VPP_FLAGS_PRESENCE_DETECT_MASK          (0x0030)
+#define MPI3_MAN11_BKPLANE_VPP_FLAGS_PRESENCE_DETECT_GPIO          (0x0000)
+#define MPI3_MAN11_BKPLANE_VPP_FLAGS_PRESENCE_DETECT_REG           (0x0010)
+#define MPI3_MAN11_BKPLANE_VPP_FLAGS_POLL_INTERVAL_MASK            (0x000f)
+#define MPI3_MAN11_BKPLANE_VPP_FLAGS_POLL_INTERVAL_SHIFT           (0)
+union _mpi3_man11_bkplane_spec_format {
+	struct _mpi3_man11_bkplane_spec_ubm_format     ubm;
+	struct _mpi3_man11_bkplane_spec_vpp_format     vpp;
+};
+
+struct _mpi3_man11_bkplane_mgmt_device_format {
+	u8                                        type;
+	u8                                        receptacle_id;
+	__le16                                    reserved02;
+	union _mpi3_man11_bkplane_spec_format         backplane_mgmt_specific;
+};
+
+#define MPI3_MAN11_BKPLANE_MGMT_TYPE_UBM            (0x00)
+#define MPI3_MAN11_BKPLANE_MGMT_TYPE_VPP            (0x01)
+struct _mpi3_man11_gas_gauge_device_format {
+	u8         type;
+	u8         reserved01[3];
+	__le32     reserved04;
+};
+
+#define MPI3_MAN11_GAS_GAUGE_TYPE_STANDARD          (0x00)
+union _mpi3_man11_device_specific_format {
+	struct _mpi3_man11_mux_device_format            mux;
+	struct _mpi3_man11_temp_sensor_device_format    temp_sensor;
+	struct _mpi3_man11_seeprom_device_format        seeprom;
+	struct _mpi3_man11_ddr_spd_device_format        ddr_spd;
+	struct _mpi3_man11_cable_mgmt_device_format     cable_mgmt;
+	struct _mpi3_man11_bkplane_mgmt_device_format   bkplane_mgmt;
+	struct _mpi3_man11_gas_gauge_device_format      gas_gauge;
+	__le32                                     words[2];
+};
+
+struct _mpi3_man11_istwi_device_format {
+	u8                                     device_type;
+	u8                                     controller;
+	u8                                     reserved02;
+	u8                                     flags;
+	__le16                                 device_address;
+	u8                                     mux_channel;
+	u8                                     mux_index;
+	union _mpi3_man11_device_specific_format   device_specific;
+};
+
+#define MPI3_MAN11_ISTWI_DEVTYPE_MUX                  (0x00)
+#define MPI3_MAN11_ISTWI_DEVTYPE_TEMP_SENSOR          (0x01)
+#define MPI3_MAN11_ISTWI_DEVTYPE_SEEPROM              (0x02)
+#define MPI3_MAN11_ISTWI_DEVTYPE_DDR_SPD              (0x03)
+#define MPI3_MAN11_ISTWI_DEVTYPE_CABLE_MGMT           (0x04)
+#define MPI3_MAN11_ISTWI_DEVTYPE_BACKPLANE_MGMT       (0x05)
+#define MPI3_MAN11_ISTWI_DEVTYPE_GAS_GAUGE            (0x06)
+#define MPI3_MAN11_ISTWI_FLAGS_MUX_PRESENT            (0x01)
+#define MPI3_MAN11_ISTWI_FLAGS_BUS_SPEED_MASK         (0x06)
+#define MPI3_MAN11_ISTWI_FLAGS_BUS_SPEED_100KHZ       (0x00)
+#define MPI3_MAN11_ISTWI_FLAGS_BUS_SPEED_400KHZ       (0x02)
+#ifndef MPI3_MAN11_ISTWI_DEVICE_MAX
+#define MPI3_MAN11_ISTWI_DEVICE_MAX             (1)
+#endif
+struct _mpi3_man_page11 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_istwi_dev;
+	u8                                 reserved0d[3];
+	struct _mpi3_man11_istwi_device_format  istwi_device[MPI3_MAN11_ISTWI_DEVICE_MAX];
+};
+
+#define MPI3_MAN11_PAGEVERSION                  (0x00)
+#ifndef MPI3_MAN12_NUM_SGPIO_MAX
+#define MPI3_MAN12_NUM_SGPIO_MAX                                     (1)
+#endif
+struct _mpi3_man12_sgpio_info {
+	u8                                 slot_count;
+	u8                                 reserved01[3];
+	__le32                             reserved04;
+	u8                                 phy_order[32];
+};
+
+struct _mpi3_man_page12 {
+	struct _mpi3_config_page_header         header;
+	__le32                             flags;
+	__le32                             s_clock_freq;
+	__le32                             activity_modulation;
+	u8                                 num_sgpio;
+	u8                                 reserved15[3];
+	__le32                             reserved18;
+	__le32                             reserved1c;
+	__le32                             pattern[8];
+	struct _mpi3_man12_sgpio_info           sgpio_info[MPI3_MAN12_NUM_SGPIO_MAX];
+};
+
+#define MPI3_MAN12_PAGEVERSION                                       (0x00)
+#define MPI3_MAN12_FLAGS_ERROR_PRESENCE_ENABLED                      (0x0400)
+#define MPI3_MAN12_FLAGS_ACTIVITY_INVERT_ENABLED                     (0x0200)
+#define MPI3_MAN12_FLAGS_GROUP_ID_DISABLED                           (0x0100)
+#define MPI3_MAN12_FLAGS_SIO_CLK_FILTER_ENABLED                      (0x0004)
+#define MPI3_MAN12_FLAGS_SCLOCK_SLOAD_TYPE_MASK                      (0x0002)
+#define MPI3_MAN12_FLAGS_SCLOCK_SLOAD_TYPE_PUSH_PULL                 (0x0000)
+#define MPI3_MAN12_FLAGS_SCLOCK_SLOAD_TYPE_OPEN_DRAIN                (0x0002)
+#define MPI3_MAN12_FLAGS_SDATAOUT_TYPE_MASK                          (0x0001)
+#define MPI3_MAN12_FLAGS_SDATAOUT_TYPE_PUSH_PULL                     (0x0000)
+#define MPI3_MAN12_FLAGS_SDATAOUT_TYPE_OPEN_DRAIN                    (0x0001)
+#define MPI3_MAN12_SIO_CLK_FREQ_MIN                                  (32)
+#define MPI3_MAN12_SIO_CLK_FREQ_MAX                                  (100000)
+#define MPI3_MAN12_ACTIVITY_MODULATION_FORCE_OFF_MASK                (0x0000f000)
+#define MPI3_MAN12_ACTIVITY_MODULATION_FORCE_OFF_SHIFT               (12)
+#define MPI3_MAN12_ACTIVITY_MODULATION_MAX_ON_MASK                   (0x00000f00)
+#define MPI3_MAN12_ACTIVITY_MODULATION_MAX_ON_SHIFT                  (8)
+#define MPI3_MAN12_ACTIVITY_MODULATION_STRETCH_OFF_MASK              (0x000000f0)
+#define MPI3_MAN12_ACTIVITY_MODULATION_STRETCH_OFF_SHIFT             (4)
+#define MPI3_MAN12_ACTIVITY_MODULATION_STRETCH_ON_MASK               (0x0000000f)
+#define MPI3_MAN12_ACTIVITY_MODULATION_STRETCH_ON_SHIFT              (0)
+#define MPI3_MAN12_PATTERN_RATE_MASK                                 (0xe0000000)
+#define MPI3_MAN12_PATTERN_RATE_2_HZ                                 (0x00000000)
+#define MPI3_MAN12_PATTERN_RATE_4_HZ                                 (0x20000000)
+#define MPI3_MAN12_PATTERN_RATE_8_HZ                                 (0x40000000)
+#define MPI3_MAN12_PATTERN_RATE_16_HZ                                (0x60000000)
+#define MPI3_MAN12_PATTERN_RATE_10_HZ                                (0x80000000)
+#define MPI3_MAN12_PATTERN_RATE_20_HZ                                (0xa0000000)
+#define MPI3_MAN12_PATTERN_RATE_40_HZ                                (0xc0000000)
+#define MPI3_MAN12_PATTERN_LENGTH_MASK                               (0x1f000000)
+#define MPI3_MAN12_PATTERN_LENGTH_SHIFT                              (24)
+#define MPI3_MAN12_PATTERN_BIT_PATTERN_MASK                          (0x00ffffff)
+#define MPI3_MAN12_PATTERN_BIT_PATTERN_SHIFT                         (0)
+#ifndef MPI3_MAN13_NUM_TRANSLATION_MAX
+#define MPI3_MAN13_NUM_TRANSLATION_MAX                               (1)
+#endif
+struct _mpi3_man13_translation_info {
+	__le32                             slot_status;
+	__le32                             mask;
+	u8                                 activity;
+	u8                                 locate;
+	u8                                 error;
+	u8                                 reserved0b;
+};
+
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_FAULT                     (0x20000000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_DEVICE_OFF                (0x10000000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_DEVICE_ACTIVITY           (0x00800000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_DO_NOT_REMOVE             (0x00400000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_DEVICE_MISSING            (0x00100000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_INSERT                    (0x00080000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_REMOVAL                   (0x00040000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_IDENTIFY                  (0x00020000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_OK                        (0x00008000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_RESERVED_DEVICE           (0x00004000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_HOT_SPARE                 (0x00002000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_CONSISTENCY_CHECK         (0x00001000)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_IN_CRITICAL_ARRAY         (0x00000800)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_IN_FAILED_ARRAY           (0x00000400)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_REBUILD_REMAP             (0x00000200)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_REBUILD_REMAP_ABORT       (0x00000100)
+#define MPI3_MAN13_TRANSLATION_SLOTSTATUS_PREDICTED_FAILURE         (0x00000040)
+#define MPI3_MAN13_BLINK_PATTERN_FORCE_OFF                          (0x00)
+#define MPI3_MAN13_BLINK_PATTERN_FORCE_ON                           (0x01)
+#define MPI3_MAN13_BLINK_PATTERN_PATTERN_0                          (0x02)
+#define MPI3_MAN13_BLINK_PATTERN_PATTERN_1                          (0x03)
+#define MPI3_MAN13_BLINK_PATTERN_PATTERN_2                          (0x04)
+#define MPI3_MAN13_BLINK_PATTERN_PATTERN_3                          (0x05)
+#define MPI3_MAN13_BLINK_PATTERN_PATTERN_4                          (0x06)
+#define MPI3_MAN13_BLINK_PATTERN_PATTERN_5                          (0x07)
+#define MPI3_MAN13_BLINK_PATTERN_PATTERN_6                          (0x08)
+#define MPI3_MAN13_BLINK_PATTERN_PATTERN_7                          (0x09)
+#define MPI3_MAN13_BLINK_PATTERN_ACTIVITY                           (0x0a)
+#define MPI3_MAN13_BLINK_PATTERN_ACTIVITY_TRAIL                     (0x0b)
+struct _mpi3_man_page13 {
+	struct _mpi3_config_page_header         header;
+	u8                                 num_trans;
+	u8                                 reserved09[3];
+	__le32                             reserved0c;
+	struct _mpi3_man13_translation_info     translation[MPI3_MAN13_NUM_TRANSLATION_MAX];
+};
+
+#define MPI3_MAN13_PAGEVERSION                                       (0x00)
+struct _mpi3_man_page14 {
+	struct _mpi3_config_page_header         header;
+	__le16                             flags;
+	__le16                             reserved0a;
+	u8                                 num_slot_groups;
+	u8                                 num_slots;
+	__le16                             max_cert_chain_length;
+	__le32                             sealed_slots;
+};
+
+#define MPI3_MAN14_PAGEVERSION                                       (0x00)
+#define MPI3_MAN14_FLAGS_AUTH_SESSION_REQ                            (0x01)
+#define MPI3_MAN14_FLAGS_AUTH_API_MASK                               (0x0e)
+#define MPI3_MAN14_FLAGS_AUTH_API_NONE                               (0x00)
+#define MPI3_MAN14_FLAGS_AUTH_API_CEREBUS                            (0x02)
+#define MPI3_MAN14_FLAGS_AUTH_API_DMTF_PMCI                          (0x04)
+#ifndef MPI3_MAN15_VERSION_RECORD_MAX
+#define MPI3_MAN15_VERSION_RECORD_MAX      1
+#endif
+struct _mpi3_man15_version_record {
+	__le16                             spdm_version;
+	__le16                             reserved02;
+};
+
+struct _mpi3_man_page15 {
+	struct _mpi3_config_page_header         header;
+	u8                                 num_version_records;
+	u8                                 reserved09[3];
+	__le32                             reserved0c;
+	struct _mpi3_man15_version_record       version_record[MPI3_MAN15_VERSION_RECORD_MAX];
+};
+
+#define MPI3_MAN15_PAGEVERSION                                       (0x00)
+#ifndef MPI3_MAN16_CERT_ALGO_MAX
+#define MPI3_MAN16_CERT_ALGO_MAX      1
+#endif
+struct _mpi3_man16_certificate_algorithm {
+	u8                                      slot_group;
+	u8                                      reserved01[3];
+	__le32                                  base_asym_algo;
+	__le32                                  base_hash_algo;
+	__le32                                  reserved0c[3];
+};
+
+struct _mpi3_man_page16 {
+	struct _mpi3_config_page_header              header;
+	__le32                                  reserved08;
+	u8                                      num_cert_algos;
+	u8                                      reserved0d[3];
+	struct _mpi3_man16_certificate_algorithm     certificate_algorithm[MPI3_MAN16_CERT_ALGO_MAX];
+};
+
+#define MPI3_MAN16_PAGEVERSION                                       (0x00)
+#ifndef MPI3_MAN17_HASH_ALGORITHM_MAX
+#define MPI3_MAN17_HASH_ALGORITHM_MAX      1
+#endif
+struct _mpi3_man17_hash_algorithm {
+	u8                                 meas_specification;
+	u8                                 reserved01[3];
+	__le32                             measurement_hash_algo;
+	__le32                             reserved08[2];
+};
+
+struct _mpi3_man_page17 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_hash_algos;
+	u8                                 reserved0d[3];
+	struct _mpi3_man17_hash_algorithm       hash_algorithm[MPI3_MAN17_HASH_ALGORITHM_MAX];
+};
+
+#define MPI3_MAN17_PAGEVERSION                                       (0x00)
+struct _mpi3_man_page20 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	__le32                             nonpremium_features;
+	u8                                 allowed_personalities;
+	u8                                 reserved11[3];
+};
+
+#define MPI3_MAN20_PAGEVERSION                                       (0x00)
+#define MPI3_MAN20_ALLOWEDPERSON_RAID_MASK                           (0x02)
+#define MPI3_MAN20_ALLOWEDPERSON_RAID_ALLOWED                        (0x02)
+#define MPI3_MAN20_ALLOWEDPERSON_RAID_NOT_ALLOWED                    (0x00)
+#define MPI3_MAN20_ALLOWEDPERSON_EHBA_MASK                           (0x01)
+#define MPI3_MAN20_ALLOWEDPERSON_EHBA_ALLOWED                        (0x01)
+#define MPI3_MAN20_ALLOWEDPERSON_EHBA_NOT_ALLOWED                    (0x00)
+#define MPI3_MAN20_NONPREMUIM_DISABLE_PD_DEGRADED_MASK               (0x01)
+#define MPI3_MAN20_NONPREMUIM_DISABLE_PD_DEGRADED_ENABLED            (0x00)
+#define MPI3_MAN20_NONPREMUIM_DISABLE_PD_DEGRADED_DISABLED           (0x01)
+struct _mpi3_man_page21 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	__le32                             flags;
+};
+
+#define MPI3_MAN21_PAGEVERSION                                       (0x00)
+#define MPI3_MAN21_FLAGS_HOST_METADATA_CAPABILITY_MASK               (0x80)
+#define MPI3_MAN21_FLAGS_HOST_METADATA_CAPABILITY_ENABLED            (0x80)
+#define MPI3_MAN21_FLAGS_HOST_METADATA_CAPABILITY_DISABLED           (0x00)
+#define MPI3_MAN21_FLAGS_UNCERTIFIED_DRIVES_MASK                     (0x60)
+#define MPI3_MAN21_FLAGS_UNCERTIFIED_DRIVES_BLOCK                    (0x00)
+#define MPI3_MAN21_FLAGS_UNCERTIFIED_DRIVES_ALLOW                    (0x20)
+#define MPI3_MAN21_FLAGS_UNCERTIFIED_DRIVES_WARN                     (0x40)
+#define MPI3_MAN21_FLAGS_BLOCK_SSD_WR_CACHE_CHANGE_MASK              (0x08)
+#define MPI3_MAN21_FLAGS_BLOCK_SSD_WR_CACHE_CHANGE_ALLOW             (0x00)
+#define MPI3_MAN21_FLAGS_BLOCK_SSD_WR_CACHE_CHANGE_PREVENT           (0x08)
+#define MPI3_MAN21_FLAGS_SES_VPD_ASSOC_MASK                          (0x01)
+#define MPI3_MAN21_FLAGS_SES_VPD_ASSOC_DEFAULT                       (0x00)
+#define MPI3_MAN21_FLAGS_SES_VPD_ASSOC_OEM_SPECIFIC                  (0x01)
+#ifndef MPI3_MAN_PROD_SPECIFIC_MAX
+#define MPI3_MAN_PROD_SPECIFIC_MAX                      (1)
+#endif
+struct _mpi3_man_page_product_specific {
+	struct _mpi3_config_page_header         header;
+	__le32                             product_specific_info[MPI3_MAN_PROD_SPECIFIC_MAX];
+};
+
+struct _mpi3_io_unit_page0 {
+	struct _mpi3_config_page_header         header;
+	__le64                             unique_value;
+	__le32                             nvdata_version_default;
+	__le32                             nvdata_version_persistent;
+};
+
+#define MPI3_IOUNIT0_PAGEVERSION                (0x00)
+struct _mpi3_io_unit_page1 {
+	struct _mpi3_config_page_header         header;
+	__le32                             flags;
+	u8                                 dmd_io_delay;
+	u8                                 dmd_report_pc_ie;
+	u8                                 dmd_report_sata;
+	u8                                 dmd_report_sas;
+};
+
+#define MPI3_IOUNIT1_PAGEVERSION                (0x00)
+#define MPI3_IOUNIT1_FLAGS_NVME_WRITE_CACHE_MASK                   (0x00000030)
+#define MPI3_IOUNIT1_FLAGS_NVME_WRITE_CACHE_ENABLE                 (0x00000000)
+#define MPI3_IOUNIT1_FLAGS_NVME_WRITE_CACHE_DISABLE                (0x00000010)
+#define MPI3_IOUNIT1_FLAGS_NVME_WRITE_CACHE_NO_MODIFY              (0x00000020)
+#define MPI3_IOUNIT1_FLAGS_ATA_SECURITY_FREEZE_LOCK                (0x00000008)
+#define MPI3_IOUNIT1_FLAGS_WRITE_SAME_BUFFER                       (0x00000004)
+#define MPI3_IOUNIT1_FLAGS_SATA_WRITE_CACHE_MASK                   (0x00000003)
+#define MPI3_IOUNIT1_FLAGS_SATA_WRITE_CACHE_ENABLE                 (0x00000000)
+#define MPI3_IOUNIT1_FLAGS_SATA_WRITE_CACHE_DISABLE                (0x00000001)
+#define MPI3_IOUNIT1_FLAGS_SATA_WRITE_CACHE_UNCHANGED              (0x00000002)
+#define MPI3_IOUNIT1_DMD_REPORT_DELAY_TIME_MASK                    (0x7f)
+#define MPI3_IOUNIT1_DMD_REPORT_UNIT_16_SEC                        (0x80)
+#ifndef MPI3_IO_UNIT2_GPIO_VAL_MAX
+#define MPI3_IO_UNIT2_GPIO_VAL_MAX      (1)
+#endif
+struct _mpi3_io_unit_page2 {
+	struct _mpi3_config_page_header         header;
+	u8                                 gpio_count;
+	u8                                 reserved09[3];
+	__le16                             gpio_val[MPI3_IO_UNIT2_GPIO_VAL_MAX];
+};
+
+#define MPI3_IOUNIT2_PAGEVERSION                (0x00)
+#define MPI3_IOUNIT2_GPIO_FUNCTION_MASK         (0xfffc)
+#define MPI3_IOUNIT2_GPIO_FUNCTION_SHIFT        (2)
+#define MPI3_IOUNIT2_GPIO_SETTING_MASK          (0x0001)
+#define MPI3_IOUNIT2_GPIO_SETTING_OFF           (0x0000)
+#define MPI3_IOUNIT2_GPIO_SETTING_ON            (0x0001)
+struct _mpi3_io_unit3_sensor {
+	__le16             flags;
+	__le16             reserved02;
+	__le16             threshold[4];
+	__le32             reserved0c;
+	__le32             reserved10;
+	__le32             reserved14;
+};
+
+#define MPI3_IOUNIT3_SENSOR_FLAGS_T3_ENABLE         (0x0008)
+#define MPI3_IOUNIT3_SENSOR_FLAGS_T2_ENABLE         (0x0004)
+#define MPI3_IOUNIT3_SENSOR_FLAGS_T1_ENABLE         (0x0002)
+#define MPI3_IOUNIT3_SENSOR_FLAGS_T0_ENABLE         (0x0001)
+#ifndef MPI3_IO_UNIT3_SENSOR_MAX
+#define MPI3_IO_UNIT3_SENSOR_MAX        (1)
+#endif
+struct _mpi3_io_unit_page3 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_sensors;
+	u8                                 polling_interval;
+	__le16                             reserved0e;
+	struct _mpi3_io_unit3_sensor            sensor[MPI3_IO_UNIT3_SENSOR_MAX];
+};
+
+#define MPI3_IOUNIT3_PAGEVERSION                (0x00)
+struct _mpi3_io_unit4_sensor {
+	__le16             current_temperature;
+	__le16             reserved02;
+	u8                 flags;
+	u8                 reserved05[3];
+	__le32             reserved08;
+	__le32             reserved0c;
+};
+
+#define MPI3_IOUNIT4_SENSOR_FLAGS_TEMP_VALID        (0x01)
+#ifndef MPI3_IO_UNIT4_SENSOR_MAX
+#define MPI3_IO_UNIT4_SENSOR_MAX        (1)
+#endif
+struct _mpi3_io_unit_page4 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_sensors;
+	u8                                 reserved0d[3];
+	struct _mpi3_io_unit4_sensor            sensor[MPI3_IO_UNIT4_SENSOR_MAX];
+};
+
+#define MPI3_IOUNIT4_PAGEVERSION                (0x00)
+struct _mpi3_io_unit5_spinup_group {
+	u8                 max_target_spinup;
+	u8                 spinup_delay;
+	u8                 spinup_flags;
+	u8                 reserved03;
+};
+
+#define MPI3_IOUNIT5_SPINUP_FLAGS_DISABLE       (0x01)
+#ifndef MPI3_IO_UNIT5_PHY_MAX
+#define MPI3_IO_UNIT5_PHY_MAX       (4)
+#endif
+struct _mpi3_io_unit_page5 {
+	struct _mpi3_config_page_header         header;
+	struct _mpi3_io_unit5_spinup_group      spinup_group_parameters[4];
+	__le32                             reserved18;
+	__le32                             reserved1c;
+	__le32                             reserved20;
+	u8                                 reserved24;
+	u8                                 sata_device_wait_time;
+	u8                                 spinup_encl_drive_count;
+	u8                                 spinup_encl_delay;
+	u8                                 num_phys;
+	u8                                 pe_initial_spinup_delay;
+	u8                                 topology_stable_time;
+	u8                                 flags;
+	u8                                 phy[MPI3_IO_UNIT5_PHY_MAX];
+};
+
+#define MPI3_IOUNIT5_PAGEVERSION                           (0x00)
+#define MPI3_IOUNIT5_FLAGS_POWER_CAPABLE_SPINUP            (0x02)
+#define MPI3_IOUNIT5_FLAGS_AUTO_PORT_ENABLE                (0x01)
+#define MPI3_IOUNIT5_PHY_SPINUP_GROUP_MASK                 (0x03)
+struct _mpi3_io_unit_page6 {
+	struct _mpi3_config_page_header         header;
+	__le32                             board_power_requirement;
+	__le32                             pci_slot_power_allocation;
+	u8                                 flags;
+	u8                                 reserved11[3];
+};
+
+#define MPI3_IOUNIT6_PAGEVERSION                (0x00)
+#define MPI3_IOUNIT6_FLAGS_ACT_CABLE_PWR_EXC    (0x01)
+struct _mpi3_io_unit_page7 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+};
+
+#define MPI3_IOUNIT7_PAGEVERSION                (0x00)
+#ifndef MPI3_IOUNIT8_DIGEST_MAX
+#define MPI3_IOUNIT8_DIGEST_MAX                   (1)
+#endif
+union _mpi3_iounit8_digest {
+	__le32                             dword[16];
+	__le16                             word[32];
+	u8                                 byte[64];
+};
+
+struct _mpi3_io_unit_page8 {
+	struct _mpi3_config_page_header         header;
+	u8                                 sb_mode;
+	u8                                 sb_state;
+	__le16                             reserved0a;
+	u8                                 num_slots;
+	u8                                 slots_available;
+	u8                                 current_key_encryption_algo;
+	u8                                 key_digest_hash_algo;
+	__le32                             reserved10[2];
+	__le32                             current_key[128];
+	union _mpi3_iounit8_digest             digest[MPI3_IOUNIT8_DIGEST_MAX];
+};
+
+#define MPI3_IOUNIT8_PAGEVERSION                  (0x00)
+#define MPI3_IOUNIT8_SBMODE_SECURE_DEBUG          (0x04)
+#define MPI3_IOUNIT8_SBMODE_HARD_SECURE           (0x02)
+#define MPI3_IOUNIT8_SBMODE_CONFIG_SECURE         (0x01)
+#define MPI3_IOUNIT8_SBSTATE_KEY_UPDATE_PENDING   (0x02)
+#define MPI3_IOUNIT8_SBSTATE_SECURE_BOOT_ENABLED  (0x01)
+struct _mpi3_io_unit_page9 {
+	struct _mpi3_config_page_header         header;
+	__le32                             flags;
+	__le16                             first_device;
+	__le16                             reserved0e;
+};
+
+#define MPI3_IOUNIT9_PAGEVERSION                  (0x00)
+#define MPI3_IOUNIT9_FLAGS_VDFIRST_ENABLED         (0x01)
+#define MPI3_IOUNIT9_FIRSTDEVICE_UNKNOWN          (0xffff)
+struct _mpi3_ioc_page0 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	__le16                             vendor_id;
+	__le16                             device_id;
+	u8                                 revision_id;
+	u8                                 reserved11[3];
+	__le32                             class_code;
+	__le16                             subsystem_vendor_id;
+	__le16                             subsystem_id;
+};
+
+#define MPI3_IOC0_PAGEVERSION               (0x00)
+struct _mpi3_ioc_page1 {
+	struct _mpi3_config_page_header         header;
+	__le32                             coalescing_timeout;
+	u8                                 coalescing_depth;
+	u8                                 pci_slot_num;
+	__le16                             reserved0e;
+};
+
+#define MPI3_IOC1_PAGEVERSION               (0x00)
+#define MPI3_IOC1_PCISLOTNUM_UNKNOWN        (0xff)
+#ifndef MPI3_IOC2_EVENTMASK_WORDS
+#define MPI3_IOC2_EVENTMASK_WORDS           (4)
+#endif
+struct _mpi3_ioc_page2 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	__le16                             sas_broadcast_primitive_masks;
+	__le16                             sas_notify_primitive_masks;
+	__le32                             event_masks[MPI3_IOC2_EVENTMASK_WORDS];
+};
+
+#define MPI3_IOC2_PAGEVERSION               (0x00)
+struct _mpi3_uefibsd_page0 {
+	struct _mpi3_config_page_header         header;
+	__le32                             bsd_options;
+	u8                                 ssu_timeout;
+	u8                                 io_timeout;
+	u8                                 tur_retries;
+	u8                                 tur_interval;
+	u8                                 reserved10;
+	u8                                 security_key_timeout;
+	__le16                             reserved12;
+	__le32                             reserved14;
+	__le32                             reserved18;
+};
+
+#define MPI3_UEFIBSD_PAGEVERSION               (0x00)
+#define MPI3_UEFIBSD_BSDOPTS_REGISTRATION_MASK              (0x00000003)
+#define MPI3_UEFIBSD_BSDOPTS_REGISTRATION_IOC_AND_DEVS      (0x00000000)
+#define MPI3_UEFIBSD_BSDOPTS_REGISTRATION_IOC_ONLY          (0x00000001)
+#define MPI3_UEFIBSD_BSDOPTS_REGISTRATION_NONE              (0x00000002)
+#define MPI3_UEFIBSD_BSDOPTS_DIS_HII_CONFIG_UTIL            (0x00000004)
+#define MPI3_UEFIBSD_BSDOPTS_EN_ADV_ADAPTER_CONFIG          (0x00000008)
+union _mpi3_security_mac {
+	__le32                             dword[16];
+	__le16                             word[32];
+	u8                                 byte[64];
+};
+
+union _mpi3_security_nonce {
+	__le32                             dword[16];
+	__le16                             word[32];
+	u8                                 byte[64];
+};
+
+union _mpi3_security0_cert_chain {
+	__le32                             dword[1024];
+	__le16                             word[2048];
+	u8                                 byte[4096];
+};
+
+struct _mpi3_security_page0 {
+	struct _mpi3_config_page_header         header;
+	u8                                 slot_num_group;
+	u8                                 slot_num;
+	__le16                             cert_chain_length;
+	u8                                 cert_chain_flags;
+	u8                                 reserved0d[3];
+	__le32                             base_asym_algo;
+	__le32                             base_hash_algo;
+	__le32                             reserved18[4];
+	union _mpi3_security_mac               mac;
+	union _mpi3_security_nonce             nonce;
+	union _mpi3_security0_cert_chain       certificate_chain;
+};
+
+#define MPI3_SECURITY0_PAGEVERSION               (0x00)
+#define MPI3_SECURITY0_CERTCHAIN_FLAGS_AUTH_API_MASK       (0x0e)
+#define MPI3_SECURITY0_CERTCHAIN_FLAGS_AUTH_API_UNUSED     (0x00)
+#define MPI3_SECURITY0_CERTCHAIN_FLAGS_AUTH_API_CERBERUS   (0x02)
+#define MPI3_SECURITY0_CERTCHAIN_FLAGS_AUTH_API_SPDM       (0x04)
+#define MPI3_SECURITY0_CERTCHAIN_FLAGS_SEALED              (0x01)
+#ifndef MPI3_SECURITY1_KEY_RECORD_MAX
+#define MPI3_SECURITY1_KEY_RECORD_MAX      1
+#endif
+#ifndef MPI3_SECURITY1_PAD_MAX
+#define MPI3_SECURITY1_PAD_MAX      1
+#endif
+union _mpi3_security1_key_data {
+	__le32                             dword[128];
+	__le16                             word[256];
+	u8                                 byte[512];
+};
+
+struct _mpi3_security1_key_record {
+	u8                                 flags;
+	u8                                 consumer;
+	__le16                             key_data_size;
+	__le32                             additional_key_data;
+	__le32                             reserved08[2];
+	union _mpi3_security1_key_data         key_data;
+};
+
+#define MPI3_SECURITY1_KEY_RECORD_FLAGS_TYPE_MASK            (0x1f)
+#define MPI3_SECURITY1_KEY_RECORD_FLAGS_TYPE_NOT_VALID       (0x00)
+#define MPI3_SECURITY1_KEY_RECORD_FLAGS_TYPE_HMAC            (0x01)
+#define MPI3_SECURITY1_KEY_RECORD_FLAGS_TYPE_AES             (0x02)
+#define MPI3_SECURITY1_KEY_RECORD_FLAGS_TYPE_ECDSA_PRIVATE   (0x03)
+#define MPI3_SECURITY1_KEY_RECORD_FLAGS_TYPE_ECDSA_PUBLIC    (0x04)
+#define MPI3_SECURITY1_KEY_RECORD_CONSUMER_NOT_VALID         (0x00)
+#define MPI3_SECURITY1_KEY_RECORD_CONSUMER_SAFESTORE         (0x01)
+#define MPI3_SECURITY1_KEY_RECORD_CONSUMER_CERT_CHAIN        (0x02)
+#define MPI3_SECURITY1_KEY_RECORD_CONSUMER_AUTH_DEV_KEY      (0x03)
+#define MPI3_SECURITY1_KEY_RECORD_CONSUMER_CACHE_OFFLOAD     (0x04)
+struct _mpi3_security_page1 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08[2];
+	union _mpi3_security_mac               mac;
+	union _mpi3_security_nonce             nonce;
+	u8                                 num_keys;
+	u8                                 reserved91[3];
+	__le32                             reserved94[3];
+	struct _mpi3_security1_key_record       key_record[MPI3_SECURITY1_KEY_RECORD_MAX];
+	u8                                 pad[MPI3_SECURITY1_PAD_MAX];
+};
+
+#define MPI3_SECURITY1_PAGEVERSION               (0x00)
+struct _mpi3_sas_io_unit0_phy_data {
+	u8                 io_unit_port;
+	u8                 port_flags;
+	u8                 phy_flags;
+	u8                 negotiated_link_rate;
+	__le16             controller_phy_device_info;
+	__le16             reserved06;
+	__le16             attached_dev_handle;
+	__le16             controller_dev_handle;
+	__le32             discovery_status;
+	__le32             reserved10;
+};
+
+#ifndef MPI3_SAS_IO_UNIT0_PHY_MAX
+#define MPI3_SAS_IO_UNIT0_PHY_MAX           (1)
+#endif
+struct _mpi3_sas_io_unit_page0 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_phys;
+	u8                                 reserved0d[3];
+	struct _mpi3_sas_io_unit0_phy_data      phy_data[MPI3_SAS_IO_UNIT0_PHY_MAX];
+};
+
+#define MPI3_SASIOUNIT0_PAGEVERSION                         (0x00)
+#define MPI3_SASIOUNIT0_PORTFLAGS_DISC_IN_PROGRESS          (0x08)
+#define MPI3_SASIOUNIT0_PORTFLAGS_AUTO_PORT_CONFIG          (0x01)
+#define MPI3_SASIOUNIT0_PHYFLAGS_INIT_PERSIST_CONNECT       (0x40)
+#define MPI3_SASIOUNIT0_PHYFLAGS_TARG_PERSIST_CONNECT       (0x20)
+#define MPI3_SASIOUNIT0_PHYFLAGS_PHY_DISABLED               (0x08)
+struct _mpi3_sas_io_unit1_phy_data {
+	u8                 io_unit_port;
+	u8                 port_flags;
+	u8                 phy_flags;
+	u8                 max_min_link_rate;
+	__le16             controller_phy_device_info;
+	__le16             max_target_port_connect_time;
+	__le32             reserved08;
+};
+
+#ifndef MPI3_SAS_IO_UNIT1_PHY_MAX
+#define MPI3_SAS_IO_UNIT1_PHY_MAX           (1)
+#endif
+struct _mpi3_sas_io_unit_page1 {
+	struct _mpi3_config_page_header         header;
+	__le16                             control_flags;
+	__le16                             sas_narrow_max_queue_depth;
+	__le16                             additional_control_flags;
+	__le16                             sas_wide_max_queue_depth;
+	u8                                 num_phys;
+	u8                                 sata_max_q_depth;
+	__le16                             reserved12;
+	struct _mpi3_sas_io_unit1_phy_data      phy_data[MPI3_SAS_IO_UNIT1_PHY_MAX];
+};
+
+#define MPI3_SASIOUNIT1_PAGEVERSION                                 (0x00)
+#define MPI3_SASIOUNIT1_CONTROL_CONTROLLER_DEVICE_SELF_TEST         (0x8000)
+#define MPI3_SASIOUNIT1_CONTROL_SATA_SW_PRESERVE                    (0x1000)
+#define MPI3_SASIOUNIT1_CONTROL_SATA_48BIT_LBA_REQUIRED             (0x0080)
+#define MPI3_SASIOUNIT1_CONTROL_SATA_SMART_REQUIRED                 (0x0040)
+#define MPI3_SASIOUNIT1_CONTROL_SATA_NCQ_REQUIRED                   (0x0020)
+#define MPI3_SASIOUNIT1_CONTROL_SATA_FUA_REQUIRED                   (0x0010)
+#define MPI3_SASIOUNIT1_CONTROL_TABLE_SUBTRACTIVE_ILLEGAL           (0x0008)
+#define MPI3_SASIOUNIT1_CONTROL_SUBTRACTIVE_ILLEGAL                 (0x0004)
+#define MPI3_SASIOUNIT1_CONTROL_FIRST_LVL_DISC_ONLY                 (0x0002)
+#define MPI3_SASIOUNIT1_CONTROL_HARD_RESET_MASK                     (0x0001)
+#define MPI3_SASIOUNIT1_CONTROL_HARD_RESET_DEVICE_NAME              (0x0000)
+#define MPI3_SASIOUNIT1_CONTROL_HARD_RESET_SAS_ADDRESS              (0x0001)
+#define MPI3_SASIOUNIT1_ACONTROL_DA_PERSIST_CONNECT                 (0x0100)
+#define MPI3_SASIOUNIT1_ACONTROL_MULTI_PORT_DOMAIN_ILLEGAL          (0x0080)
+#define MPI3_SASIOUNIT1_ACONTROL_SATA_ASYNCHROUNOUS_NOTIFICATION    (0x0040)
+#define MPI3_SASIOUNIT1_ACONTROL_INVALID_TOPOLOGY_CORRECTION        (0x0020)
+#define MPI3_SASIOUNIT1_ACONTROL_PORT_ENABLE_ONLY_SATA_LINK_RESET   (0x0010)
+#define MPI3_SASIOUNIT1_ACONTROL_OTHER_AFFILIATION_SATA_LINK_RESET  (0x0008)
+#define MPI3_SASIOUNIT1_ACONTROL_SELF_AFFILIATION_SATA_LINK_RESET   (0x0004)
+#define MPI3_SASIOUNIT1_ACONTROL_NO_AFFILIATION_SATA_LINK_RESET     (0x0002)
+#define MPI3_SASIOUNIT1_ACONTROL_ALLOW_TABLE_TO_TABLE               (0x0001)
+#define MPI3_SASIOUNIT1_PORT_FLAGS_AUTO_PORT_CONFIG                 (0x01)
+#define MPI3_SASIOUNIT1_PHYFLAGS_INIT_PERSIST_CONNECT               (0x40)
+#define MPI3_SASIOUNIT1_PHYFLAGS_TARG_PERSIST_CONNECT               (0x20)
+#define MPI3_SASIOUNIT1_PHYFLAGS_PHY_DISABLE                        (0x08)
+#define MPI3_SASIOUNIT1_MMLR_MAX_RATE_MASK                          (0xf0)
+#define MPI3_SASIOUNIT1_MMLR_MAX_RATE_SHIFT                         (4)
+#define MPI3_SASIOUNIT1_MMLR_MAX_RATE_6_0                           (0xa0)
+#define MPI3_SASIOUNIT1_MMLR_MAX_RATE_12_0                          (0xb0)
+#define MPI3_SASIOUNIT1_MMLR_MAX_RATE_22_5                          (0xc0)
+#define MPI3_SASIOUNIT1_MMLR_MIN_RATE_MASK                          (0x0f)
+#define MPI3_SASIOUNIT1_MMLR_MIN_RATE_6_0                           (0x0a)
+#define MPI3_SASIOUNIT1_MMLR_MIN_RATE_12_0                          (0x0b)
+#define MPI3_SASIOUNIT1_MMLR_MIN_RATE_22_5                          (0x0c)
+struct _mpi3_sas_io_unit2_phy_pm_settings {
+	u8                 control_flags;
+	u8                 reserved01;
+	__le16             inactivity_timer_exponent;
+	u8                 sata_partial_timeout;
+	u8                 reserved05;
+	u8                 sata_slumber_timeout;
+	u8                 reserved07;
+	u8                 sas_partial_timeout;
+	u8                 reserved09;
+	u8                 sas_slumber_timeout;
+	u8                 reserved0b;
+};
+
+#ifndef MPI3_SAS_IO_UNIT2_PHY_MAX
+#define MPI3_SAS_IO_UNIT2_PHY_MAX           (1)
+#endif
+struct _mpi3_sas_io_unit_page2 {
+	struct _mpi3_config_page_header             header;
+	u8                                     num_phys;
+	u8                                     reserved09[3];
+	__le32                                 reserved0c;
+	struct _mpi3_sas_io_unit2_phy_pm_settings   sas_phy_power_management_settings[MPI3_SAS_IO_UNIT2_PHY_MAX];
+};
+
+#define MPI3_SASIOUNIT2_PAGEVERSION                     (0x00)
+#define MPI3_SASIOUNIT2_CONTROL_SAS_SLUMBER_ENABLE      (0x08)
+#define MPI3_SASIOUNIT2_CONTROL_SAS_PARTIAL_ENABLE      (0x04)
+#define MPI3_SASIOUNIT2_CONTROL_SATA_SLUMBER_ENABLE     (0x02)
+#define MPI3_SASIOUNIT2_CONTROL_SATA_PARTIAL_ENABLE     (0x01)
+#define MPI3_SASIOUNIT2_ITE_SAS_SLUMBER_MASK            (0x7000)
+#define MPI3_SASIOUNIT2_ITE_SAS_SLUMBER_SHIFT           (12)
+#define MPI3_SASIOUNIT2_ITE_SAS_PARTIAL_MASK            (0x0700)
+#define MPI3_SASIOUNIT2_ITE_SAS_PARTIAL_SHIFT           (8)
+#define MPI3_SASIOUNIT2_ITE_SATA_SLUMBER_MASK           (0x0070)
+#define MPI3_SASIOUNIT2_ITE_SATA_SLUMBER_SHIFT          (4)
+#define MPI3_SASIOUNIT2_ITE_SATA_PARTIAL_MASK           (0x0007)
+#define MPI3_SASIOUNIT2_ITE_SATA_PARTIAL_SHIFT          (0)
+#define MPI3_SASIOUNIT2_ITE_EXP_TEN_SECONDS             (7)
+#define MPI3_SASIOUNIT2_ITE_EXP_ONE_SECOND              (6)
+#define MPI3_SASIOUNIT2_ITE_EXP_HUNDRED_MILLISECONDS    (5)
+#define MPI3_SASIOUNIT2_ITE_EXP_TEN_MILLISECONDS        (4)
+#define MPI3_SASIOUNIT2_ITE_EXP_ONE_MILLISECOND         (3)
+#define MPI3_SASIOUNIT2_ITE_EXP_HUNDRED_MICROSECONDS    (2)
+#define MPI3_SASIOUNIT2_ITE_EXP_TEN_MICROSECONDS        (1)
+#define MPI3_SASIOUNIT2_ITE_EXP_ONE_MICROSECOND         (0)
+struct _mpi3_sas_io_unit_page3 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	__le32                             power_management_capabilities;
+};
+
+#define MPI3_SASIOUNIT3_PAGEVERSION                     (0x00)
+#define MPI3_SASIOUNIT3_PM_HOST_SAS_SLUMBER_MODE        (0x00000800)
+#define MPI3_SASIOUNIT3_PM_HOST_SAS_PARTIAL_MODE        (0x00000400)
+#define MPI3_SASIOUNIT3_PM_HOST_SATA_SLUMBER_MODE       (0x00000200)
+#define MPI3_SASIOUNIT3_PM_HOST_SATA_PARTIAL_MODE       (0x00000100)
+#define MPI3_SASIOUNIT3_PM_IOUNIT_SAS_SLUMBER_MODE      (0x00000008)
+#define MPI3_SASIOUNIT3_PM_IOUNIT_SAS_PARTIAL_MODE      (0x00000004)
+#define MPI3_SASIOUNIT3_PM_IOUNIT_SATA_SLUMBER_MODE     (0x00000002)
+#define MPI3_SASIOUNIT3_PM_IOUNIT_SATA_PARTIAL_MODE     (0x00000001)
+struct _mpi3_sas_expander_page0 {
+	struct _mpi3_config_page_header         header;
+	u8                                 io_unit_port;
+	u8                                 report_gen_length;
+	__le16                             enclosure_handle;
+	__le32                             reserved0c;
+	__le64                             sas_address;
+	__le32                             discovery_status;
+	__le16                             dev_handle;
+	__le16                             parent_dev_handle;
+	__le16                             expander_change_count;
+	__le16                             expander_route_indexes;
+	u8                                 num_phys;
+	u8                                 sas_level;
+	__le16                             flags;
+	__le16                             stp_bus_inactivity_time_limit;
+	__le16                             stp_max_connect_time_limit;
+	__le16                             stp_smp_nexus_loss_time;
+	__le16                             max_num_routed_sas_addresses;
+	__le64                             active_zone_manager_sas_address;
+	__le16                             zone_lock_inactivity_limit;
+	__le16                             reserved3a;
+	u8                                 time_to_reduced_func;
+	u8                                 initial_time_to_reduced_func;
+	u8                                 max_reduced_func_time;
+	u8                                 exp_status;
+};
+
+#define MPI3_SASEXPANDER0_PAGEVERSION                       (0x00)
+#define MPI3_SASEXPANDER0_FLAGS_REDUCED_FUNCTIONALITY       (0x2000)
+#define MPI3_SASEXPANDER0_FLAGS_ZONE_LOCKED                 (0x1000)
+#define MPI3_SASEXPANDER0_FLAGS_SUPPORTED_PHYSICAL_PRES     (0x0800)
+#define MPI3_SASEXPANDER0_FLAGS_ASSERTED_PHYSICAL_PRES      (0x0400)
+#define MPI3_SASEXPANDER0_FLAGS_ZONING_SUPPORT              (0x0200)
+#define MPI3_SASEXPANDER0_FLAGS_ENABLED_ZONING              (0x0100)
+#define MPI3_SASEXPANDER0_FLAGS_TABLE_TO_TABLE_SUPPORT      (0x0080)
+#define MPI3_SASEXPANDER0_FLAGS_CONNECTOR_END_DEVICE        (0x0010)
+#define MPI3_SASEXPANDER0_FLAGS_OTHERS_CONFIG               (0x0004)
+#define MPI3_SASEXPANDER0_FLAGS_CONFIG_IN_PROGRESS          (0x0002)
+#define MPI3_SASEXPANDER0_FLAGS_ROUTE_TABLE_CONFIG          (0x0001)
+#define MPI3_SASEXPANDER0_ES_NOT_RESPONDING                 (0x02)
+#define MPI3_SASEXPANDER0_ES_RESPONDING                     (0x03)
+#define MPI3_SASEXPANDER0_ES_DELAY_NOT_RESPONDING           (0x04)
+struct _mpi3_sas_expander_page1 {
+	struct _mpi3_config_page_header         header;
+	u8                                 io_unit_port;
+	u8                                 reserved09[3];
+	u8                                 num_phys;
+	u8                                 phy;
+	__le16                             num_table_entries_programmed;
+	u8                                 programmed_link_rate;
+	u8                                 hw_link_rate;
+	__le16                             attached_dev_handle;
+	__le32                             phy_info;
+	__le16                             attached_device_info;
+	__le16                             reserved1a;
+	__le16                             expander_dev_handle;
+	u8                                 change_count;
+	u8                                 negotiated_link_rate;
+	u8                                 phy_identifier;
+	u8                                 attached_phy_identifier;
+	u8                                 reserved22;
+	u8                                 discovery_info;
+	__le32                             attached_phy_info;
+	u8                                 zone_group;
+	u8                                 self_config_status;
+	__le16                             reserved2a;
+	__le16                             slot;
+	__le16                             slot_index;
+};
+
+#define MPI3_SASEXPANDER1_PAGEVERSION                   (0x00)
+#define MPI3_SASEXPANDER1_DISCINFO_BAD_PHY_DISABLED     (0x04)
+#define MPI3_SASEXPANDER1_DISCINFO_LINK_STATUS_CHANGE   (0x02)
+#define MPI3_SASEXPANDER1_DISCINFO_NO_ROUTING_ENTRIES   (0x01)
+struct _mpi3_sas_port_page0 {
+	struct _mpi3_config_page_header         header;
+	u8                                 port_number;
+	u8                                 reserved09;
+	u8                                 port_width;
+	u8                                 reserved0b;
+	u8                                 zone_group;
+	u8                                 reserved0d[3];
+	__le64                             sas_address;
+	__le16                             device_info;
+	__le16                             reserved1a;
+	__le32                             reserved1c;
+};
+
+#define MPI3_SASPORT0_PAGEVERSION                       (0x00)
+struct _mpi3_sas_phy_page0 {
+	struct _mpi3_config_page_header         header;
+	__le16                             owner_dev_handle;
+	__le16                             reserved0a;
+	__le16                             attached_dev_handle;
+	u8                                 attached_phy_identifier;
+	u8                                 reserved0f;
+	__le32                             attached_phy_info;
+	u8                                 programmed_link_rate;
+	u8                                 hw_link_rate;
+	u8                                 change_count;
+	u8                                 flags;
+	__le32                             phy_info;
+	u8                                 negotiated_link_rate;
+	u8                                 reserved1d[3];
+	__le16                             slot;
+	__le16                             slot_index;
+};
+
+#define MPI3_SASPHY0_PAGEVERSION                        (0x00)
+#define MPI3_SASPHY0_FLAGS_SGPIO_DIRECT_ATTACH_ENC      (0x01)
+struct _mpi3_sas_phy_page1 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	__le32                             invalid_dword_count;
+	__le32                             running_disparity_error_count;
+	__le32                             loss_dword_synch_count;
+	__le32                             phy_reset_problem_count;
+};
+
+#define MPI3_SASPHY1_PAGEVERSION                        (0x00)
+struct _mpi3_sas_phy2_phy_event {
+	u8         phy_event_code;
+	u8         reserved01[3];
+	__le32     phy_event_info;
+};
+
+#ifndef MPI3_SAS_PHY2_PHY_EVENT_MAX
+#define MPI3_SAS_PHY2_PHY_EVENT_MAX         (1)
+#endif
+struct _mpi3_sas_phy_page2 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_phy_events;
+	u8                                 reserved0d[3];
+	struct _mpi3_sas_phy2_phy_event         phy_event[MPI3_SAS_PHY2_PHY_EVENT_MAX];
+};
+
+#define MPI3_SASPHY2_PAGEVERSION                        (0x00)
+struct _mpi3_sas_phy3_phy_event_config {
+	u8         phy_event_code;
+	u8         reserved01[3];
+	u8         counter_type;
+	u8         threshold_window;
+	u8         time_units;
+	u8         reserved07;
+	__le32     event_threshold;
+	__le16     threshold_flags;
+	__le16     reserved0e;
+};
+
+#define MPI3_SASPHY3_EVENT_CODE_NO_EVENT                    (0x00)
+#define MPI3_SASPHY3_EVENT_CODE_INVALID_DWORD               (0x01)
+#define MPI3_SASPHY3_EVENT_CODE_RUNNING_DISPARITY_ERROR     (0x02)
+#define MPI3_SASPHY3_EVENT_CODE_LOSS_DWORD_SYNC             (0x03)
+#define MPI3_SASPHY3_EVENT_CODE_PHY_RESET_PROBLEM           (0x04)
+#define MPI3_SASPHY3_EVENT_CODE_ELASTICITY_BUF_OVERFLOW     (0x05)
+#define MPI3_SASPHY3_EVENT_CODE_RX_ERROR                    (0x06)
+#define MPI3_SASPHY3_EVENT_CODE_INV_SPL_PACKETS             (0x07)
+#define MPI3_SASPHY3_EVENT_CODE_LOSS_SPL_PACKET_SYNC        (0x08)
+#define MPI3_SASPHY3_EVENT_CODE_RX_ADDR_FRAME_ERROR         (0x20)
+#define MPI3_SASPHY3_EVENT_CODE_TX_AC_OPEN_REJECT           (0x21)
+#define MPI3_SASPHY3_EVENT_CODE_RX_AC_OPEN_REJECT           (0x22)
+#define MPI3_SASPHY3_EVENT_CODE_TX_RC_OPEN_REJECT           (0x23)
+#define MPI3_SASPHY3_EVENT_CODE_RX_RC_OPEN_REJECT           (0x24)
+#define MPI3_SASPHY3_EVENT_CODE_RX_AIP_PARTIAL_WAITING_ON   (0x25)
+#define MPI3_SASPHY3_EVENT_CODE_RX_AIP_CONNECT_WAITING_ON   (0x26)
+#define MPI3_SASPHY3_EVENT_CODE_TX_BREAK                    (0x27)
+#define MPI3_SASPHY3_EVENT_CODE_RX_BREAK                    (0x28)
+#define MPI3_SASPHY3_EVENT_CODE_BREAK_TIMEOUT               (0x29)
+#define MPI3_SASPHY3_EVENT_CODE_CONNECTION                  (0x2a)
+#define MPI3_SASPHY3_EVENT_CODE_PEAKTX_PATHWAY_BLOCKED      (0x2b)
+#define MPI3_SASPHY3_EVENT_CODE_PEAKTX_ARB_WAIT_TIME        (0x2c)
+#define MPI3_SASPHY3_EVENT_CODE_PEAK_ARB_WAIT_TIME          (0x2d)
+#define MPI3_SASPHY3_EVENT_CODE_PEAK_CONNECT_TIME           (0x2e)
+#define MPI3_SASPHY3_EVENT_CODE_PERSIST_CONN                (0x2f)
+#define MPI3_SASPHY3_EVENT_CODE_TX_SSP_FRAMES               (0x40)
+#define MPI3_SASPHY3_EVENT_CODE_RX_SSP_FRAMES               (0x41)
+#define MPI3_SASPHY3_EVENT_CODE_TX_SSP_ERROR_FRAMES         (0x42)
+#define MPI3_SASPHY3_EVENT_CODE_RX_SSP_ERROR_FRAMES         (0x43)
+#define MPI3_SASPHY3_EVENT_CODE_TX_CREDIT_BLOCKED           (0x44)
+#define MPI3_SASPHY3_EVENT_CODE_RX_CREDIT_BLOCKED           (0x45)
+#define MPI3_SASPHY3_EVENT_CODE_TX_SATA_FRAMES              (0x50)
+#define MPI3_SASPHY3_EVENT_CODE_RX_SATA_FRAMES              (0x51)
+#define MPI3_SASPHY3_EVENT_CODE_SATA_OVERFLOW               (0x52)
+#define MPI3_SASPHY3_EVENT_CODE_TX_SMP_FRAMES               (0x60)
+#define MPI3_SASPHY3_EVENT_CODE_RX_SMP_FRAMES               (0x61)
+#define MPI3_SASPHY3_EVENT_CODE_RX_SMP_ERROR_FRAMES         (0x63)
+#define MPI3_SASPHY3_EVENT_CODE_HOTPLUG_TIMEOUT             (0xd0)
+#define MPI3_SASPHY3_EVENT_CODE_MISALIGNED_MUX_PRIMITIVE    (0xd1)
+#define MPI3_SASPHY3_EVENT_CODE_RX_AIP                      (0xd2)
+#define MPI3_SASPHY3_EVENT_CODE_LCARB_WAIT_TIME             (0xd3)
+#define MPI3_SASPHY3_EVENT_CODE_RCVD_CONN_RESP_WAIT_TIME    (0xd4)
+#define MPI3_SASPHY3_EVENT_CODE_LCCONN_TIME                 (0xd5)
+#define MPI3_SASPHY3_EVENT_CODE_SSP_TX_START_TRANSMIT       (0xd6)
+#define MPI3_SASPHY3_EVENT_CODE_SATA_TX_START               (0xd7)
+#define MPI3_SASPHY3_EVENT_CODE_SMP_TX_START_TRANSMT        (0xd8)
+#define MPI3_SASPHY3_EVENT_CODE_TX_SMP_BREAK_CONN           (0xd9)
+#define MPI3_SASPHY3_EVENT_CODE_SSP_RX_START_RECEIVE        (0xda)
+#define MPI3_SASPHY3_EVENT_CODE_SATA_RX_START_RECEIVE       (0xdb)
+#define MPI3_SASPHY3_EVENT_CODE_SMP_RX_START_RECEIVE        (0xdc)
+#define MPI3_SASPHY3_COUNTER_TYPE_WRAPPING                  (0x00)
+#define MPI3_SASPHY3_COUNTER_TYPE_SATURATING                (0x01)
+#define MPI3_SASPHY3_COUNTER_TYPE_PEAK_VALUE                (0x02)
+#define MPI3_SASPHY3_TIME_UNITS_10_MICROSECONDS             (0x00)
+#define MPI3_SASPHY3_TIME_UNITS_100_MICROSECONDS            (0x01)
+#define MPI3_SASPHY3_TIME_UNITS_1_MILLISECOND               (0x02)
+#define MPI3_SASPHY3_TIME_UNITS_10_MILLISECONDS             (0x03)
+#define MPI3_SASPHY3_TFLAGS_PHY_RESET                       (0x0002)
+#define MPI3_SASPHY3_TFLAGS_EVENT_NOTIFY                    (0x0001)
+#ifndef MPI3_SAS_PHY3_PHY_EVENT_MAX
+#define MPI3_SAS_PHY3_PHY_EVENT_MAX         (1)
+#endif
+struct _mpi3_sas_phy_page3 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_phy_events;
+	u8                                 reserved0d[3];
+	struct _mpi3_sas_phy3_phy_event_config  phy_event_config[MPI3_SAS_PHY3_PHY_EVENT_MAX];
+};
+
+#define MPI3_SASPHY3_PAGEVERSION                        (0x00)
+struct _mpi3_sas_phy_page4 {
+	struct _mpi3_config_page_header         header;
+	u8                                 reserved08[3];
+	u8                                 flags;
+	u8                                 initial_frame[28];
+};
+
+#define MPI3_SASPHY4_PAGEVERSION                        (0x00)
+#define MPI3_SASPHY4_FLAGS_FRAME_VALID                  (0x02)
+#define MPI3_SASPHY4_FLAGS_SATA_FRAME                   (0x01)
+#define MPI3_PCIE_LINK_RETIMERS_MASK                    (0x30)
+#define MPI3_PCIE_LINK_RETIMERS_SHIFT                   (4)
+#define MPI3_PCIE_NEG_LINK_RATE_MASK                    (0x0f)
+#define MPI3_PCIE_NEG_LINK_RATE_UNKNOWN                 (0x00)
+#define MPI3_PCIE_NEG_LINK_RATE_PHY_DISABLED            (0x01)
+#define MPI3_PCIE_NEG_LINK_RATE_2_5                     (0x02)
+#define MPI3_PCIE_NEG_LINK_RATE_5_0                     (0x03)
+#define MPI3_PCIE_NEG_LINK_RATE_8_0                     (0x04)
+#define MPI3_PCIE_NEG_LINK_RATE_16_0                    (0x05)
+#define MPI3_PCIE_NEG_LINK_RATE_32_0                    (0x06)
+struct _mpi3_pcie_io_unit0_phy_data {
+	u8         link;
+	u8         link_flags;
+	u8         phy_flags;
+	u8         negotiated_link_rate;
+	__le16     attached_dev_handle;
+	__le16     controller_dev_handle;
+	__le32     enumeration_status;
+	u8         io_unit_port;
+	u8         reserved0d[3];
+};
+
+#define MPI3_PCIEIOUNIT0_LINKFLAGS_CONFIG_SOURCE_MASK      (0x10)
+#define MPI3_PCIEIOUNIT0_LINKFLAGS_CONFIG_SOURCE_IOUNIT1   (0x00)
+#define MPI3_PCIEIOUNIT0_LINKFLAGS_CONFIG_SOURCE_BKPLANE   (0x10)
+#define MPI3_PCIEIOUNIT0_LINKFLAGS_ENUM_IN_PROGRESS        (0x08)
+#define MPI3_PCIEIOUNIT0_PHYFLAGS_PHY_DISABLED          (0x08)
+#define MPI3_PCIEIOUNIT0_PHYFLAGS_HOST_PHY              (0x01)
+#define MPI3_PCIEIOUNIT0_ES_MAX_SWITCH_DEPTH_EXCEEDED   (0x80000000)
+#define MPI3_PCIEIOUNIT0_ES_MAX_SWITCHES_EXCEEDED       (0x40000000)
+#define MPI3_PCIEIOUNIT0_ES_MAX_ENDPOINTS_EXCEEDED      (0x20000000)
+#define MPI3_PCIEIOUNIT0_ES_INSUFFICIENT_RESOURCES      (0x10000000)
+#ifndef MPI3_PCIE_IO_UNIT0_PHY_MAX
+#define MPI3_PCIE_IO_UNIT0_PHY_MAX      (1)
+#endif
+struct _mpi3_pcie_io_unit_page0 {
+	struct _mpi3_config_page_header         header;
+	__le32                             reserved08;
+	u8                                 num_phys;
+	u8                                 init_status;
+	__le16                             reserved0e;
+	struct _mpi3_pcie_io_unit0_phy_data     phy_data[MPI3_PCIE_IO_UNIT0_PHY_MAX];
+};
+
+#define MPI3_PCIEIOUNIT0_PAGEVERSION                        (0x00)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_NO_ERRORS               (0x00)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_NEEDS_INITIALIZATION    (0x01)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_NO_TARGETS_ALLOCATED    (0x02)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_RESOURCE_ALLOC_FAILED   (0x03)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_BAD_NUM_PHYS            (0x04)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_UNSUPPORTED_CONFIG      (0x05)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_HOST_PORT_MISMATCH      (0x06)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_PHYS_NOT_CONSECUTIVE    (0x07)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_BAD_CLOCKING_MODE       (0x08)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_PROD_SPEC_START         (0xf0)
+#define MPI3_PCIEIOUNIT0_INITSTATUS_PROD_SPEC_END           (0xff)
+struct _mpi3_pcie_io_unit1_phy_data {
+	u8         link;
+	u8         link_flags;
+	u8         phy_flags;
+	u8         max_min_link_rate;
+	__le32     reserved04;
+	__le32     reserved08;
+};
+
+#define MPI3_PCIEIOUNIT1_LINKFLAGS_PCIE_CLK_MODE_MASK                     (0x03)
+#define MPI3_PCIEIOUNIT1_LINKFLAGS_PCIE_CLK_MODE_DIS_SEPARATE_REFCLK      (0x00)
+#define MPI3_PCIEIOUNIT1_LINKFLAGS_PCIE_CLK_MODE_EN_SRIS                  (0x01)
+#define MPI3_PCIEIOUNIT1_LINKFLAGS_PCIE_CLK_MODE_EN_SRNS                  (0x02)
+#define MPI3_PCIEIOUNIT1_PHYFLAGS_PHY_DISABLE               (0x08)
+#define MPI3_PCIEIOUNIT1_MMLR_MAX_RATE_MASK                      (0xf0)
+#define MPI3_PCIEIOUNIT1_MMLR_MAX_RATE_SHIFT                     (4)
+#define MPI3_PCIEIOUNIT1_MMLR_MAX_RATE_2_5                       (0x20)
+#define MPI3_PCIEIOUNIT1_MMLR_MAX_RATE_5_0                       (0x30)
+#define MPI3_PCIEIOUNIT1_MMLR_MAX_RATE_8_0                       (0x40)
+#define MPI3_PCIEIOUNIT1_MMLR_MAX_RATE_16_0                      (0x50)
+#define MPI3_PCIEIOUNIT1_MMLR_MAX_RATE_32_0                      (0x60)
+#ifndef MPI3_PCIE_IO_UNIT1_PHY_MAX
+#define MPI3_PCIE_IO_UNIT1_PHY_MAX          (1)
+#endif
+struct _mpi3_pcie_io_unit_page1 {
+	struct _mpi3_config_page_header         header;
+	__le32                             control_flags;
+	__le32                             reserved0c;
+	u8                                 num_phys;
+	u8                                 reserved11;
+	__le16                             reserved12;
+	struct _mpi3_pcie_io_unit1_phy_data     phy_data[MPI3_PCIE_IO_UNIT1_PHY_MAX];
+};
+
+#define MPI3_PCIEIOUNIT1_PAGEVERSION                        (0x00)
+struct _mpi3_pcie_io_unit_page2 {
+	struct _mpi3_config_page_header         header;
+	__le16                             nv_me_max_queue_depth;
+	__le16                             reserved0a;
+	u8                                 nv_me_abort_to;
+	u8                                 reserved0d;
+	__le16                             reserved0e;
+};
+
+#define MPI3_PCIEIOUNIT2_PAGEVERSION                        (0x00)
+struct _mpi3_pcie_switch_page0 {
+	struct _mpi3_config_page_header     header;
+	u8                             io_unit_port;
+	u8                             switch_status;
+	u8                             reserved0a[2];
+	__le16                         dev_handle;
+	__le16                         parent_dev_handle;
+	u8                             num_ports;
+	u8                             pc_ie_level;
+	__le16                         reserved12;
+	__le32                         reserved14;
+	__le32                         reserved18;
+	__le32                         reserved1c;
+};
+
+#define MPI3_PCIESWITCH0_PAGEVERSION                  (0x00)
+#define MPI3_PCIESWITCH0_SS_NOT_RESPONDING            (0x02)
+#define MPI3_PCIESWITCH0_SS_RESPONDING                (0x03)
+#define MPI3_PCIESWITCH0_SS_DELAY_NOT_RESPONDING      (0x04)
+struct _mpi3_pcie_switch_page1 {
+	struct _mpi3_config_page_header     header;
+	u8                             io_unit_port;
+	u8                             reserved09[3];
+	u8                             num_ports;
+	u8                             port_num;
+	__le16                         attached_dev_handle;
+	__le16                         switch_dev_handle;
+	u8                             negotiated_port_width;
+	u8                             negotiated_link_rate;
+	__le16                         slot;
+	__le16                         slot_index;
+	__le32                         reserved18;
+};
+
+#define MPI3_PCIESWITCH1_PAGEVERSION        (0x00)
+struct _mpi3_pcie_link_page0 {
+	struct _mpi3_config_page_header     header;
+	u8                             link;
+	u8                             reserved09[3];
+	__le32                         correctable_error_count;
+	__le16                         n_fatal_error_count;
+	__le16                         reserved12;
+	__le16                         fatal_error_count;
+	__le16                         reserved16;
+};
+
+#define MPI3_PCIELINK0_PAGEVERSION          (0x00)
+struct _mpi3_enclosure_page0 {
+	struct _mpi3_config_page_header         header;
+	__le64                             enclosure_logical_id;
+	__le16                             flags;
+	__le16                             enclosure_handle;
+	__le16                             num_slots;
+	__le16                             start_slot;
+	u8                                 io_unit_port;
+	u8                                 enclosure_level;
+	__le16                             sep_dev_handle;
+	__le32                             reserved1c;
+};
+
+#define MPI3_ENCLOSURE0_PAGEVERSION                     (0x00)
+#define MPI3_ENCLS0_FLAGS_ENCL_TYPE_MASK                (0xc000)
+#define MPI3_ENCLS0_FLAGS_ENCL_TYPE_VIRTUAL             (0x0000)
+#define MPI3_ENCLS0_FLAGS_ENCL_TYPE_SAS                 (0x4000)
+#define MPI3_ENCLS0_FLAGS_ENCL_TYPE_PCIE                (0x8000)
+#define MPI3_ENCLS0_FLAGS_ENCL_DEV_PRESENT_MASK         (0x0010)
+#define MPI3_ENCLS0_FLAGS_ENCL_DEV_NOT_FOUND            (0x0000)
+#define MPI3_ENCLS0_FLAGS_ENCL_DEV_PRESENT              (0x0010)
+#define MPI3_ENCLS0_FLAGS_MNG_MASK                      (0x000f)
+#define MPI3_ENCLS0_FLAGS_MNG_UNKNOWN                   (0x0000)
+#define MPI3_ENCLS0_FLAGS_MNG_IOC_SES                   (0x0001)
+#define MPI3_ENCLS0_FLAGS_MNG_SES_ENCLOSURE             (0x0002)
+#define MPI3_DEVICE_DEVFORM_SAS_SATA                    (0x00)
+#define MPI3_DEVICE_DEVFORM_PCIE                        (0x01)
+#define MPI3_DEVICE_DEVFORM_VD                          (0x02)
+struct _mpi3_device0_sas_sata_format {
+	__le64     sas_address;
+	__le16     flags;
+	__le16     device_info;
+	u8         phy_num;
+	u8         attached_phy_identifier;
+	u8         max_port_connections;
+	u8         zone_group;
+};
+
+#define MPI3_DEVICE0_SASSATA_FLAGS_SLUMBER_CAP          (0x0200)
+#define MPI3_DEVICE0_SASSATA_FLAGS_PARTIAL_CAP          (0x0100)
+#define MPI3_DEVICE0_SASSATA_FLAGS_ASYNC_NOTIFY         (0x0080)
+#define MPI3_DEVICE0_SASSATA_FLAGS_SW_PRESERVE          (0x0040)
+#define MPI3_DEVICE0_SASSATA_FLAGS_UNSUPP_DEV           (0x0020)
+#define MPI3_DEVICE0_SASSATA_FLAGS_48BIT_LBA            (0x0010)
+#define MPI3_DEVICE0_SASSATA_FLAGS_SMART_SUPP           (0x0008)
+#define MPI3_DEVICE0_SASSATA_FLAGS_NCQ_SUPP             (0x0004)
+#define MPI3_DEVICE0_SASSATA_FLAGS_FUA_SUPP             (0x0002)
+#define MPI3_DEVICE0_SASSATA_FLAGS_PERSIST_CAP          (0x0001)
+struct _mpi3_device0_pcie_format {
+	u8         supported_link_rates;
+	u8         max_port_width;
+	u8         negotiated_port_width;
+	u8         negotiated_link_rate;
+	u8         port_num;
+	u8         controller_reset_to;
+	__le16     device_info;
+	__le32     maximum_data_transfer_size;
+	__le32     capabilities;
+	__le16     noiob;
+	u8         nv_me_abort_to;
+	u8         page_size;
+	__le16     shutdown_latency;
+	__le16     reserved16;
+};
+
+#define MPI3_DEVICE0_PCIE_LINK_RATE_32_0_SUPP           (0x10)
+#define MPI3_DEVICE0_PCIE_LINK_RATE_16_0_SUPP           (0x08)
+#define MPI3_DEVICE0_PCIE_LINK_RATE_8_0_SUPP            (0x04)
+#define MPI3_DEVICE0_PCIE_LINK_RATE_5_0_SUPP            (0x02)
+#define MPI3_DEVICE0_PCIE_LINK_RATE_2_5_SUPP            (0x01)
+#define MPI3_DEVICE0_PCIE_DEVICE_INFO_TYPE_MASK             (0x0003)
+#define MPI3_DEVICE0_PCIE_DEVICE_INFO_TYPE_NO_DEVICE        (0x0000)
+#define MPI3_DEVICE0_PCIE_DEVICE_INFO_TYPE_NVME_DEVICE      (0x0001)
+#define MPI3_DEVICE0_PCIE_DEVICE_INFO_TYPE_SWITCH_DEVICE    (0x0002)
+#define MPI3_DEVICE0_PCIE_DEVICE_INFO_TYPE_SCSI_DEVICE      (0x0003)
+#define MPI3_DEVICE0_PCIE_CAP_METADATA_SEPARATED            (0x00000010)
+#define MPI3_DEVICE0_PCIE_CAP_SGL_DWORD_ALIGN_REQUIRED      (0x00000008)
+#define MPI3_DEVICE0_PCIE_CAP_NVME_SGL_ENABLED              (0x00000004)
+#define MPI3_DEVICE0_PCIE_CAP_BIT_BUCKET_SGL_SUPP           (0x00000002)
+#define MPI3_DEVICE0_PCIE_CAP_SGL_SUPP                      (0x00000001)
+struct _mpi3_device0_vd_format {
+	u8         vd_state;
+	u8         raid_level;
+	__le16     device_info;
+	__le16     flags;
+	__le16     reserved06;
+	__le32     reserved08[2];
+};
+
+#define MPI3_DEVICE0_VD_STATE_OFFLINE                       (0x00)
+#define MPI3_DEVICE0_VD_STATE_PARTIALLY_DEGRADED            (0x01)
+#define MPI3_DEVICE0_VD_STATE_DEGRADED                      (0x02)
+#define MPI3_DEVICE0_VD_STATE_OPTIMAL                       (0x03)
+#define MPI3_DEVICE0_VD_RAIDLEVEL_RAID_0                    (0)
+#define MPI3_DEVICE0_VD_RAIDLEVEL_RAID_1                    (1)
+#define MPI3_DEVICE0_VD_RAIDLEVEL_RAID_5                    (5)
+#define MPI3_DEVICE0_VD_RAIDLEVEL_RAID_6                    (6)
+#define MPI3_DEVICE0_VD_RAIDLEVEL_RAID_10                   (10)
+#define MPI3_DEVICE0_VD_RAIDLEVEL_RAID_50                   (50)
+#define MPI3_DEVICE0_VD_RAIDLEVEL_RAID_60                   (60)
+#define MPI3_DEVICE0_VD_DEVICE_INFO_HDD                     (0x0010)
+#define MPI3_DEVICE0_VD_DEVICE_INFO_SSD                     (0x0008)
+#define MPI3_DEVICE0_VD_DEVICE_INFO_NVME                    (0x0004)
+#define MPI3_DEVICE0_VD_DEVICE_INFO_SATA                    (0x0002)
+#define MPI3_DEVICE0_VD_DEVICE_INFO_SAS                     (0x0001)
+#define MPI3_DEVICE0_VD_FLAGS_METADATA_MODE_MASK            (0x0003)
+#define MPI3_DEVICE0_VD_FLAGS_METADATA_MODE_NONE            (0x0000)
+#define MPI3_DEVICE0_VD_FLAGS_METADATA_MODE_HOST            (0x0001)
+#define MPI3_DEVICE0_VD_FLAGS_METADATA_MODE_IOC             (0x0002)
+union _mpi3_device0_dev_spec_format {
+	struct _mpi3_device0_sas_sata_format        sas_sata_format;
+	struct _mpi3_device0_pcie_format            pcie_format;
+	struct _mpi3_device0_vd_format              vd_format;
+};
+
+struct _mpi3_device_page0 {
+	struct _mpi3_config_page_header         header;
+	__le16                             dev_handle;
+	__le16                             parent_dev_handle;
+	__le16                             slot;
+	__le16                             enclosure_handle;
+	__le64                             wwid;
+	__le16                             persistent_id;
+	u8                                 io_unit_port;
+	u8                                 access_status;
+	__le16                             flags;
+	__le16                             reserved1e;
+	__le16                             slot_index;
+	__le16                             queue_depth;
+	u8                                 reserved24[3];
+	u8                                 device_form;
+	union _mpi3_device0_dev_spec_format    device_specific;
+};
+
+#define MPI3_DEVICE0_PAGEVERSION                        (0x00)
+#define MPI3_DEVICE0_WWID_INVALID                       (0xffffffffffffffff)
+#define MPI3_DEVICE0_PERSISTENTID_INVALID               (0xffff)
+#define MPI3_DEVICE0_IOUNITPORT_INVALID                 (0xff)
+#define MPI3_DEVICE0_ASTATUS_NO_ERRORS                              (0x00)
+#define MPI3_DEVICE0_ASTATUS_NEEDS_INITIALIZATION                   (0x01)
+#define MPI3_DEVICE0_ASTATUS_CAP_UNSUPPORTED                        (0x02)
+#define MPI3_DEVICE0_ASTATUS_DEVICE_BLOCKED                         (0x03)
+#define MPI3_DEVICE0_ASTATUS_UNAUTHORIZED                           (0x04)
+#define MPI3_DEVICE0_ASTATUS_DEVICE_MISSING_DELAY                   (0x05)
+#define MPI3_DEVICE0_ASTATUS_SAS_UNKNOWN                            (0x10)
+#define MPI3_DEVICE0_ASTATUS_ROUTE_NOT_ADDRESSABLE                  (0x11)
+#define MPI3_DEVICE0_ASTATUS_SMP_ERROR_NOT_ADDRESSABLE              (0x12)
+#define MPI3_DEVICE0_ASTATUS_SIF_UNKNOWN                            (0x20)
+#define MPI3_DEVICE0_ASTATUS_SIF_AFFILIATION_CONFLICT               (0x21)
+#define MPI3_DEVICE0_ASTATUS_SIF_DIAG                               (0x22)
+#define MPI3_DEVICE0_ASTATUS_SIF_IDENTIFICATION                     (0x23)
+#define MPI3_DEVICE0_ASTATUS_SIF_CHECK_POWER                        (0x24)
+#define MPI3_DEVICE0_ASTATUS_SIF_PIO_SN                             (0x25)
+#define MPI3_DEVICE0_ASTATUS_SIF_MDMA_SN                            (0x26)
+#define MPI3_DEVICE0_ASTATUS_SIF_UDMA_SN                            (0x27)
+#define MPI3_DEVICE0_ASTATUS_SIF_ZONING_VIOLATION                   (0x28)
+#define MPI3_DEVICE0_ASTATUS_SIF_NOT_ADDRESSABLE                    (0x29)
+#define MPI3_DEVICE0_ASTATUS_SIF_MAX                                (0x2f)
+#define MPI3_DEVICE0_ASTATUS_PCIE_UNKNOWN                           (0x30)
+#define MPI3_DEVICE0_ASTATUS_PCIE_MEM_SPACE_ACCESS                  (0x31)
+#define MPI3_DEVICE0_ASTATUS_PCIE_UNSUPPORTED                       (0x32)
+#define MPI3_DEVICE0_ASTATUS_PCIE_MSIX_REQUIRED                     (0x33)
+#define MPI3_DEVICE0_ASTATUS_NVME_UNKNOWN                           (0x40)
+#define MPI3_DEVICE0_ASTATUS_NVME_READY_TIMEOUT                     (0x41)
+#define MPI3_DEVICE0_ASTATUS_NVME_DEVCFG_UNSUPPORTED                (0x42)
+#define MPI3_DEVICE0_ASTATUS_NVME_IDENTIFY_FAILED                   (0x43)
+#define MPI3_DEVICE0_ASTATUS_NVME_QCONFIG_FAILED                    (0x44)
+#define MPI3_DEVICE0_ASTATUS_NVME_QCREATION_FAILED                  (0x45)
+#define MPI3_DEVICE0_ASTATUS_NVME_EVENTCFG_FAILED                   (0x46)
+#define MPI3_DEVICE0_ASTATUS_NVME_GET_FEATURE_STAT_FAILED           (0x47)
+#define MPI3_DEVICE0_ASTATUS_NVME_IDLE_TIMEOUT                      (0x48)
+#define MPI3_DEVICE0_ASTATUS_NVME_CTRL_FAILURE_STATUS               (0x49)
+#define MPI3_DEVICE0_ASTATUS_VD_UNKNOWN                             (0x50)
+#define MPI3_DEVICE0_FLAGS_CONTROLLER_DEV_HANDLE        (0x0080)
+#define MPI3_DEVICE0_FLAGS_HIDDEN                       (0x0008)
+#define MPI3_DEVICE0_FLAGS_ATT_METHOD_MASK              (0x0006)
+#define MPI3_DEVICE0_FLAGS_ATT_METHOD_NOT_DIR_ATTACHED  (0x0000)
+#define MPI3_DEVICE0_FLAGS_ATT_METHOD_DIR_ATTACHED      (0x0002)
+#define MPI3_DEVICE0_FLAGS_ATT_METHOD_VIRTUAL           (0x0004)
+#define MPI3_DEVICE0_FLAGS_DEVICE_PRESENT               (0x0001)
+#define MPI3_DEVICE0_QUEUE_DEPTH_NOT_APPLICABLE         (0x0000)
+struct _mpi3_device1_sas_sata_format {
+	__le32                             reserved00;
+};
+
+struct _mpi3_device1_pcie_format {
+	__le16                             vendor_id;
+	__le16                             device_id;
+	__le16                             subsystem_vendor_id;
+	__le16                             subsystem_id;
+	__le32                             reserved08;
+	u8                                 revision_id;
+	u8                                 reserved0d;
+	__le16                             pci_parameters;
+};
+
+#define MPI3_DEVICE1_PCIE_PARAMS_DATA_SIZE_128B              (0x0)
+#define MPI3_DEVICE1_PCIE_PARAMS_DATA_SIZE_256B              (0x1)
+#define MPI3_DEVICE1_PCIE_PARAMS_DATA_SIZE_512B              (0x2)
+#define MPI3_DEVICE1_PCIE_PARAMS_DATA_SIZE_1024B             (0x3)
+#define MPI3_DEVICE1_PCIE_PARAMS_DATA_SIZE_2048B             (0x4)
+#define MPI3_DEVICE1_PCIE_PARAMS_DATA_SIZE_4096B             (0x5)
+#define MPI3_DEVICE1_PCIE_PARAMS_MAX_READ_REQ_MASK           (0x01c0)
+#define MPI3_DEVICE1_PCIE_PARAMS_MAX_READ_REQ_SHIFT          (6)
+#define MPI3_DEVICE1_PCIE_PARAMS_CURR_MAX_PAYLOAD_MASK       (0x0038)
+#define MPI3_DEVICE1_PCIE_PARAMS_CURR_MAX_PAYLOAD_SHIFT      (3)
+#define MPI3_DEVICE1_PCIE_PARAMS_SUPP_MAX_PAYLOAD_MASK       (0x0007)
+#define MPI3_DEVICE1_PCIE_PARAMS_SUPP_MAX_PAYLOAD_SHIFT      (0)
+struct _mpi3_device1_vd_format {
+	__le32                             reserved00;
+};
+
+union _mpi3_device1_dev_spec_format {
+	struct _mpi3_device1_sas_sata_format    sas_sata_format;
+	struct _mpi3_device1_pcie_format        pcie_format;
+	struct _mpi3_device1_vd_format          vd_format;
+};
+
+struct _mpi3_device_page1 {
+	struct _mpi3_config_page_header         header;
+	__le16                             dev_handle;
+	__le16                             reserved0a;
+	__le32                             reserved0c[12];
+	u8                                 reserved3c[3];
+	u8                                 device_form;
+	union _mpi3_device1_dev_spec_format    device_specific;
+};
+
+#define MPI3_DEVICE1_PAGEVERSION                            (0x00)
+#endif
diff --git a/drivers/scsi/mpi3mr/mpi/mpi30_sas.h b/drivers/scsi/mpi3mr/mpi/mpi30_sas.h
new file mode 100644
index 000000000000..462902bc681a
--- /dev/null
+++ b/drivers/scsi/mpi3mr/mpi/mpi30_sas.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright 2016-2021 Broadcom Inc. All rights reserved.
+ *
+ *           Name: mpi30_sas.h
+ *    Description: Contains MPI Serial Attached SCSI structures and definitions
+ *  Creation Date: 12/08/2016
+ *        Version: 03.00.00
+ */
+#ifndef MPI30_SAS_H
+#define MPI30_SAS_H     1
+#define MPI3_SAS_DEVICE_INFO_SSP_TARGET             (0x00000100)
+#define MPI3_SAS_DEVICE_INFO_STP_SATA_TARGET        (0x00000080)
+#define MPI3_SAS_DEVICE_INFO_SMP_TARGET             (0x00000040)
+#define MPI3_SAS_DEVICE_INFO_SSP_INITIATOR          (0x00000020)
+#define MPI3_SAS_DEVICE_INFO_STP_INITIATOR          (0x00000010)
+#define MPI3_SAS_DEVICE_INFO_SMP_INITIATOR          (0x00000008)
+#define MPI3_SAS_DEVICE_INFO_DEVICE_TYPE_MASK       (0x00000007)
+#define MPI3_SAS_DEVICE_INFO_DEVICE_TYPE_NO_DEVICE  (0x00000000)
+#define MPI3_SAS_DEVICE_INFO_DEVICE_TYPE_END_DEVICE (0x00000001)
+#define MPI3_SAS_DEVICE_INFO_DEVICE_TYPE_EXPANDER   (0x00000002)
+struct _mpi3_smp_passthrough_request {
+	__le16                     host_tag;
+	u8                         ioc_use_only02;
+	u8                         function;
+	__le16                     ioc_use_only04;
+	u8                         ioc_use_only06;
+	u8                         msg_flags;
+	__le16                     change_count;
+	u8                         reserved0a;
+	u8                         io_unit_port;
+	__le32                     reserved0c[3];
+	__le64                     sas_address;
+	struct _mpi3_sge_common         request_sge;
+	struct _mpi3_sge_common         response_sge;
+};
+#endif
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 0ff2b3b1947b..9c6415f736c4 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -134,6 +134,10 @@ extern struct list_head mrioc_list;
 #define MPI3MR_RSP_IO_QUEUED_ON_IOC \
 			MPI3_SCSITASKMGMT_RSPCODE_IO_QUEUED_ON_IOC
 
+#define MPI3MR_DEFAULT_MDTS	(128 * 1024)
+/* Command retry count definitions */
+#define MPI3MR_DEV_RMHS_RETRY_COUNT 3
+
 /* SGE Flag definition */
 #define MPI3MR_SGEFLAGS_SYSTEM_SIMPLE_END_OF_LIST \
 	(MPI3_SGE_FLAGS_ELEMENT_TYPE_SIMPLE | MPI3_SGE_FLAGS_DLAS_SYSTEM | \
@@ -313,6 +317,126 @@ struct mpi3mr_intr_info {
 	char name[MPI3MR_NAME_LENGTH];
 };
 
+/**
+ * struct tgt_dev_sas_sata - SAS/SATA device specific
+ * information cached from firmware given data
+ *
+ * @sas_address: World wide unique SAS address
+ * @dev_info: Device information bits
+ */
+struct tgt_dev_sas_sata {
+	u64 sas_address;
+	u16 dev_info;
+};
+
+/**
+ * struct tgt_dev_pcie - PCIe device specific information cached
+ * from firmware given data
+ *
+ * @mdts: Maximum data transfer size
+ * @capb: Device capabilities
+ * @pgsz: Device page size
+ * @abort_to: Timeout for abort TM
+ * @reset_to: Timeout for Target/LUN reset TM
+ */
+struct tgt_dev_pcie {
+	u32 mdts;
+	u16 capb;
+	u8 pgsz;
+	u8 abort_to;
+	u8 reset_to;
+};
+
+/**
+ * struct tgt_dev_volume - virtual device specific information
+ * cached from firmware given data
+ *
+ * @state: State of the VD
+ */
+struct tgt_dev_volume {
+	u8 state;
+};
+
+/**
+ * union _form_spec_inf - union of device specific information
+ */
+union _form_spec_inf {
+	struct tgt_dev_sas_sata sas_sata_inf;
+	struct tgt_dev_pcie pcie_inf;
+	struct tgt_dev_volume vol_inf;
+};
+
+
+
+/**
+ * struct mpi3mr_tgt_dev - target device data structure
+ *
+ * @list: List pointer
+ * @starget: Scsi_target pointer
+ * @dev_handle: FW device handle
+ * @parent_handle: FW parent device handle
+ * @slot: Slot number
+ * @encl_handle: FW enclosure handle
+ * @perst_id: FW assigned Persistent ID
+ * @dev_type: SAS/SATA/PCIE device type
+ * @is_hidden: Should be exposed to upper layers or not
+ * @host_exposed: Already exposed to host or not
+ * @q_depth: Device specific Queue Depth
+ * @wwid: World wide ID
+ * @dev_spec: Device type specific information
+ * @ref_count: Reference count
+ */
+struct mpi3mr_tgt_dev {
+	struct list_head list;
+	struct scsi_target *starget;
+	u16 dev_handle;
+	u16 parent_handle;
+	u16 slot;
+	u16 encl_handle;
+	u16 perst_id;
+	u8 dev_type;
+	u8 is_hidden;
+	u8 host_exposed;
+	u16 q_depth;
+	u64 wwid;
+	union _form_spec_inf dev_spec;
+	struct kref ref_count;
+};
+
+/**
+ * mpi3mr_tgtdev_get - k reference incrementor
+ * @s: Target device reference
+ *
+ * Increment target device reference count.
+ */
+static inline void mpi3mr_tgtdev_get(struct mpi3mr_tgt_dev *s)
+{
+	kref_get(&s->ref_count);
+}
+
+/**
+ * mpi3mr_free_tgtdev - target device memory dealloctor
+ * @r: k reference pointer of the target device
+ *
+ * Free target device memory when no reference.
+ */
+static inline void mpi3mr_free_tgtdev(struct kref *r)
+{
+	kfree(container_of(r, struct mpi3mr_tgt_dev, ref_count));
+}
+
+/**
+ * mpi3mr_tgtdev_put - k reference decrementor
+ * @s: Target device reference
+ *
+ * Decrement target device reference count.
+ */
+static inline void mpi3mr_tgtdev_put(struct mpi3mr_tgt_dev *s)
+{
+	kref_put(&s->ref_count, mpi3mr_free_tgtdev);
+}
+
+
 /**
  * struct mpi3mr_stgt_priv_data - SCSI target private structure
  *
@@ -358,6 +482,7 @@ struct mpi3mr_sdev_priv_data {
  * @done: Completeor for wakeup
  * @reply: Firmware reply for internal commands
  * @sensebuf: Sensebuf for SCSI IO commands
+ * @iou_rc: IO Unit control reason code
  * @state: Command State
  * @dev_handle: Firmware handle for device specific commands
  * @ioc_status: IOC status from the firmware
@@ -372,6 +497,7 @@ struct mpi3mr_drv_cmd {
 	struct completion done;
 	void *reply;
 	u8 *sensebuf;
+	u8 iou_rc;
 	u16 state;
 	u16 dev_handle;
 	u16 ioc_status;
@@ -478,6 +604,11 @@ struct scmd_priv {
  * @sense_buf_q_dma: Sense buffer queue DMA address
  * @sbq_lock: Sense buffer queue lock
  * @sbq_host_index: Sense buffer queuehost index
+ * @event_masks: Event mask bitmap
+ * @fwevt_worker_name: Firmware event worker thread name
+ * @fwevt_worker_thread: Firmware event worker thread
+ * @fwevt_lock: Firmware event lock
+ * @fwevt_list: Firmware event list
  * @watchdog_work_q_name: Fault watchdog worker thread name
  * @watchdog_work_q: Fault watchdog worker thread
  * @watchdog_work: Fault watchdog work
@@ -493,6 +624,12 @@ struct scmd_priv {
  * @chain_bitmap_sz: Chain buffer allocator bitmap size
  * @chain_bitmap: Chain buffer allocator bitmap
  * @chain_buf_lock: Chain buffer list lock
+ * @dev_rmhs_cmds: Command tracker for device removal commands
+ * @devrem_bitmap_sz: Device removal bitmap size
+ * @devrem_bitmap: Device removal bitmap
+ * @dev_handle_bitmap_sz: Device handle bitmap size
+ * @removepend_bitmap: Remove pending bitmap
+ * @delayed_rmhs_list: Delayed device removal list
  * @reset_in_progress: Reset in progress flag
  * @unrecoverable: Controller unrecoverable flag
  * @diagsave_timeout: Diagnostic information save timeout
@@ -576,6 +713,12 @@ struct mpi3mr_ioc {
 	dma_addr_t sense_buf_q_dma;
 	spinlock_t sbq_lock;
 	u32 sbq_host_index;
+	u32 event_masks[MPI3_EVENT_NOTIFY_EVENTMASK_WORDS];
+
+	char fwevt_worker_name[MPI3MR_NAME_LENGTH];
+	struct workqueue_struct	*fwevt_worker_thread;
+	spinlock_t fwevt_lock;
+	struct list_head fwevt_list;
 
 	char watchdog_work_q_name[20];
 	struct workqueue_struct *watchdog_work_q;
@@ -588,6 +731,8 @@ struct mpi3mr_ioc {
 	u8 stop_drv_processing;
 
 	u16 max_host_ios;
+	spinlock_t tgtdev_lock;
+	struct list_head tgtdev_list;
 
 	u32 chain_buf_count;
 	struct dma_pool *chain_buf_pool;
@@ -596,6 +741,13 @@ struct mpi3mr_ioc {
 	void *chain_bitmap;
 	spinlock_t chain_buf_lock;
 
+	struct mpi3mr_drv_cmd dev_rmhs_cmds[MPI3MR_NUM_DEVRMCMD];
+	u16 devrem_bitmap_sz;
+	void *devrem_bitmap;
+	u16 dev_handle_bitmap_sz;
+	void *removepend_bitmap;
+	struct list_head delayed_rmhs_list;
+
 	u8 reset_in_progress;
 	u8 unrecoverable;
 
@@ -608,6 +760,45 @@ struct mpi3mr_ioc {
 	u16 op_reply_q_offset;
 };
 
+/**
+ * struct mpi3mr_fwevt - Firmware event structure.
+ *
+ * @list: list head
+ * @work: Work structure
+ * @mrioc: Adapter instance reference
+ * @event_id: MPI3 firmware event ID
+ * @send_ack: Event acknowledgment required or not
+ * @process_evt: Bottomhalf processing required or not
+ * @evt_ctx: Event context to send in Ack
+ * @ref_count: kref count
+ * @event_data: Actual MPI3 event data
+ */
+struct mpi3mr_fwevt {
+	struct list_head list;
+	struct work_struct work;
+	struct mpi3mr_ioc *mrioc;
+	u16 event_id;
+	bool send_ack;
+	bool process_evt;
+	u32 evt_ctx;
+	struct kref ref_count;
+	char event_data[0] __aligned(4);
+};
+
+
+/**
+ * struct delayed_dev_rmhs_node - Delayed device removal node
+ *
+ * @list: list head
+ * @handle: Device handle
+ * @iou_rc: IO Unit Control Reason Code
+ */
+struct delayed_dev_rmhs_node {
+	struct list_head list;
+	u16 handle;
+	u8 iou_rc;
+};
+
 int mpi3mr_setup_resources(struct mpi3mr_ioc *mrioc);
 void mpi3mr_cleanup_resources(struct mpi3mr_ioc *mrioc);
 int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc);
@@ -627,6 +818,8 @@ void *mpi3mr_get_reply_virt_addr(struct mpi3mr_ioc *mrioc,
 void mpi3mr_repost_sense_buf(struct mpi3mr_ioc *mrioc,
 				     u64 sense_buf_dma);
 
+void mpi3mr_os_handle_events(struct mpi3mr_ioc *mrioc,
+			     struct _mpi3_event_notification_reply *event_reply);
 void mpi3mr_process_op_reply_desc(struct mpi3mr_ioc *mrioc,
 				  struct _mpi3_default_reply_descriptor *reply_desc,
 				  u64 *reply_dma, u16 qidx);
@@ -639,5 +832,14 @@ void mpi3mr_ioc_disable_intr(struct mpi3mr_ioc *mrioc);
 void mpi3mr_ioc_enable_intr(struct mpi3mr_ioc *mrioc);
 
 enum mpi3mr_iocstate mpi3mr_get_iocstate(struct mpi3mr_ioc *mrioc);
+int mpi3mr_send_event_ack(struct mpi3mr_ioc *mrioc, u8 event,
+			  u32 event_ctx);
+
+void mpi3mr_wait_for_host_io(struct mpi3mr_ioc *mrioc, u32 timeout);
+void mpi3mr_cleanup_fwevt_list(struct mpi3mr_ioc *mrioc);
+void mpi3mr_flush_host_io(struct mpi3mr_ioc *mrioc);
+void mpi3mr_invalidate_devhandles(struct mpi3mr_ioc *mrioc);
+void mpi3mr_rfresh_tgtdevs(struct mpi3mr_ioc *mrioc);
+void mpi3mr_flush_delayed_rmhs_list(struct mpi3mr_ioc *mrioc);
 
 #endif /*MPI3MR_H_INCLUDED*/
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 9a750f630d5e..a5e8c7c87314 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -160,12 +160,15 @@ static void mpi3mr_handle_events(struct mpi3mr_ioc *mrioc,
 	    (struct _mpi3_event_notification_reply *)def_reply;
 
 	mrioc->change_count = le16_to_cpu(event_reply->ioc_change_count);
+	mpi3mr_os_handle_events(mrioc, event_reply);
 }
 
 static struct mpi3mr_drv_cmd *
 mpi3mr_get_drv_cmd(struct mpi3mr_ioc *mrioc, u16 host_tag,
 	struct _mpi3_default_reply *def_reply)
 {
+	u16 idx;
+
 	switch (host_tag) {
 	case MPI3MR_HOSTTAG_INITCMDS:
 		return &mrioc->init_cmds;
@@ -177,6 +180,11 @@ mpi3mr_get_drv_cmd(struct mpi3mr_ioc *mrioc, u16 host_tag,
 	default:
 		break;
 	}
+	if (host_tag >= MPI3MR_HOSTTAG_DEVRMCMD_MIN &&
+	    host_tag <= MPI3MR_HOSTTAG_DEVRMCMD_MAX) {
+		idx = host_tag - MPI3MR_HOSTTAG_DEVRMCMD_MIN;
+		return &mrioc->dev_rmhs_cmds[idx];
+	}
 
 	return NULL;
 }
@@ -1910,6 +1918,13 @@ static int mpi3mr_alloc_reply_sense_bufs(struct mpi3mr_ioc *mrioc)
 	if (!mrioc->init_cmds.reply)
 		goto out_failed;
 
+	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++) {
+		mrioc->dev_rmhs_cmds[i].reply = kzalloc(mrioc->facts.reply_sz,
+		    GFP_KERNEL);
+		if (!mrioc->dev_rmhs_cmds[i].reply)
+			goto out_failed;
+	}
+
 	mrioc->num_reply_bufs = mrioc->facts.max_reqs + MPI3MR_NUM_EVT_REPLIES;
 	mrioc->reply_free_qsz = mrioc->num_reply_bufs + 1;
 	mrioc->num_sense_bufs = mrioc->facts.max_reqs / MPI3MR_SENSEBUF_FACTOR;
@@ -2119,6 +2134,163 @@ static int mpi3mr_issue_iocinit(struct mpi3mr_ioc *mrioc)
 	return retval;
 }
 
+/**
+ * mpi3mr_unmask_events - Unmask events in event mask bitmap
+ * @mrioc: Adapter instance reference
+ * @event: MPI event ID
+ *
+ * Un mask the specific event by resetting the event_mask
+ * bitmap.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+static void mpi3mr_unmask_events(struct mpi3mr_ioc *mrioc, u16 event)
+{
+	u32 desired_event;
+	u8 word;
+
+	if (event >= 128)
+		return;
+
+	desired_event = (1 << (event % 32));
+	word = event / 32;
+
+	mrioc->event_masks[word] &= ~desired_event;
+}
+
+/**
+ * mpi3mr_issue_event_notification - Send event notification
+ * @mrioc: Adapter instance reference
+ *
+ * Issue event notification MPI request through admin queue and
+ * wait for the completion of it or time out.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+static int mpi3mr_issue_event_notification(struct mpi3mr_ioc *mrioc)
+{
+	struct _mpi3_event_notification_request evtnotify_req;
+	int retval = 0;
+	u8 i;
+
+	memset(&evtnotify_req, 0, sizeof(evtnotify_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		retval = -1;
+		ioc_err(mrioc, "Issue EvtNotify: Init command is in use\n");
+		mutex_unlock(&mrioc->init_cmds.mutex);
+		goto out;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	evtnotify_req.host_tag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	evtnotify_req.function = MPI3_FUNCTION_EVENT_NOTIFICATION;
+	for (i = 0; i < MPI3_EVENT_NOTIFY_EVENTMASK_WORDS; i++)
+		evtnotify_req.event_masks[i] =
+		    cpu_to_le32(mrioc->event_masks[i]);
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &evtnotify_req,
+	    sizeof(evtnotify_req), 1);
+	if (retval) {
+		ioc_err(mrioc, "Issue EvtNotify: Admin Post failed\n");
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		ioc_err(mrioc, "Issue EvtNotify: command timed out\n");
+		mpi3mr_set_diagsave(mrioc);
+		mpi3mr_issue_reset(mrioc,
+		    MPI3_SYSIF_HOST_DIAG_RESET_ACTION_DIAG_FAULT,
+		    MPI3MR_RESET_FROM_EVTNOTIFY_TIMEOUT);
+		mrioc->unrecoverable = 1;
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc,
+		    "Issue EvtNotify: Failed ioc_status(0x%04x) Loginfo(0x%08x)\n",
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+
+out_unlock:
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+out:
+	return retval;
+}
+
+/**
+ * mpi3mr_send_event_ack - Send event acknowledgment
+ * @mrioc: Adapter instance reference
+ * @event: MPI3 event ID
+ * @event_ctx: Event context
+ *
+ * Send event acknowledgment through admin queue and wait for
+ * it to complete.
+ *
+ * Return: 0 on success, non-zero on failures.
+ */
+int mpi3mr_send_event_ack(struct mpi3mr_ioc *mrioc, u8 event,
+	u32 event_ctx)
+{
+	struct _mpi3_event_ack_request evtack_req;
+	int retval = 0;
+
+	memset(&evtack_req, 0, sizeof(evtack_req));
+	mutex_lock(&mrioc->init_cmds.mutex);
+	if (mrioc->init_cmds.state & MPI3MR_CMD_PENDING) {
+		retval = -1;
+		ioc_err(mrioc, "Send EvtAck: Init command is in use\n");
+		mutex_unlock(&mrioc->init_cmds.mutex);
+		goto out;
+	}
+	mrioc->init_cmds.state = MPI3MR_CMD_PENDING;
+	mrioc->init_cmds.is_waiting = 1;
+	mrioc->init_cmds.callback = NULL;
+	evtack_req.host_tag = cpu_to_le16(MPI3MR_HOSTTAG_INITCMDS);
+	evtack_req.function = MPI3_FUNCTION_EVENT_ACK;
+	evtack_req.event = event;
+	evtack_req.event_context = cpu_to_le32(event_ctx);
+
+	init_completion(&mrioc->init_cmds.done);
+	retval = mpi3mr_admin_request_post(mrioc, &evtack_req,
+	    sizeof(evtack_req), 1);
+	if (retval) {
+		ioc_err(mrioc, "Send EvtAck: Admin Post failed\n");
+		goto out_unlock;
+	}
+	wait_for_completion_timeout(&mrioc->init_cmds.done,
+	    (MPI3MR_INTADMCMD_TIMEOUT * HZ));
+	if (!(mrioc->init_cmds.state & MPI3MR_CMD_COMPLETE)) {
+		ioc_err(mrioc, "Issue EvtNotify: command timed out\n");
+		mpi3mr_soft_reset_handler(mrioc,
+		    MPI3MR_RESET_FROM_EVTACK_TIMEOUT, 1);
+		retval = -1;
+		goto out_unlock;
+	}
+	if ((mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK)
+	    != MPI3_IOCSTATUS_SUCCESS) {
+		ioc_err(mrioc,
+		    "Send EvtAck: Failed ioc_status(0x%04x) Loginfo(0x%08x)\n",
+		    (mrioc->init_cmds.ioc_status & MPI3_IOCSTATUS_STATUS_MASK),
+		    mrioc->init_cmds.ioc_loginfo);
+		retval = -1;
+		goto out_unlock;
+	}
+
+out_unlock:
+	mrioc->init_cmds.state = MPI3MR_CMD_NOTUSED;
+	mutex_unlock(&mrioc->init_cmds.mutex);
+out:
+	return retval;
+}
+
 /**
  * mpi3mr_alloc_chain_bufs - Allocate chain buffers
  * @mrioc: Adapter instance reference
@@ -2396,7 +2568,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 	enum mpi3mr_iocstate ioc_state;
 	u64 base_info;
 	u32 timeout;
-	u32 ioc_status, ioc_config;
+	u32 ioc_status, ioc_config, i;
 	struct _mpi3_ioc_facts_data facts_data;
 
 	mrioc->change_count = 0;
@@ -2546,6 +2718,24 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 		goto out_failed;
 	}
 
+	for (i = 0; i < MPI3_EVENT_NOTIFY_EVENTMASK_WORDS; i++)
+		mrioc->event_masks[i] = -1;
+
+	mpi3mr_unmask_events(mrioc, MPI3_EVENT_DEVICE_ADDED);
+	mpi3mr_unmask_events(mrioc, MPI3_EVENT_DEVICE_INFO_CHANGED);
+	mpi3mr_unmask_events(mrioc, MPI3_EVENT_DEVICE_STATUS_CHANGE);
+	mpi3mr_unmask_events(mrioc, MPI3_EVENT_ENCL_DEVICE_STATUS_CHANGE);
+	mpi3mr_unmask_events(mrioc, MPI3_EVENT_SAS_TOPOLOGY_CHANGE_LIST);
+	mpi3mr_unmask_events(mrioc, MPI3_EVENT_SAS_DISCOVERY);
+	mpi3mr_unmask_events(mrioc, MPI3_EVENT_SAS_DEVICE_DISCOVERY_ERROR);
+
+	retval = mpi3mr_issue_event_notification(mrioc);
+	if (retval) {
+		ioc_err(mrioc, "Failed to issue event notification %d\n",
+		    retval);
+		goto out_failed;
+	}
+
 	return retval;
 
 out_failed:
@@ -2627,6 +2817,11 @@ static void mpi3mr_free_mem(struct mpi3mr_ioc *mrioc)
 	kfree(mrioc->chain_bitmap);
 	mrioc->chain_bitmap = NULL;
 
+	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++) {
+		kfree(mrioc->dev_rmhs_cmds[i].reply);
+		mrioc->dev_rmhs_cmds[i].reply = NULL;
+	}
+
 	if (mrioc->chain_buf_pool) {
 		for (i = 0; i < mrioc->chain_buf_count; i++) {
 			if (mrioc->chain_sgl_list[i].addr) {
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 1587c8b029ad..1b372baec295 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -125,6 +125,1268 @@ static void mpi3mr_clear_scmd_priv(struct mpi3mr_ioc *mrioc,
 	}
 }
 
+static void mpi3mr_dev_rmhs_send_tm(struct mpi3mr_ioc *mrioc, u16 handle,
+	struct mpi3mr_drv_cmd *cmdparam, u8 iou_rc);
+static void mpi3mr_fwevt_worker(struct work_struct *work);
+
+/**
+ * mpi3mr_fwevt_free - firmware event memory dealloctor
+ * @r: k reference pointer of the firmware event
+ *
+ * Free firmware event memory when no reference.
+ */
+static void mpi3mr_fwevt_free(struct kref *r)
+{
+	kfree(container_of(r, struct mpi3mr_fwevt, ref_count));
+}
+
+/**
+ * mpi3mr_fwevt_get - k reference incrementor
+ * @fwevt: Firmware event reference
+ *
+ * Increment firmware event reference count.
+ */
+static void mpi3mr_fwevt_get(struct mpi3mr_fwevt *fwevt)
+{
+	kref_get(&fwevt->ref_count);
+}
+
+/**
+ * mpi3mr_fwevt_put - k reference decrementor
+ * @fwevt: Firmware event reference
+ *
+ * decrement firmware event reference count.
+ */
+static void mpi3mr_fwevt_put(struct mpi3mr_fwevt *fwevt)
+{
+	kref_put(&fwevt->ref_count, mpi3mr_fwevt_free);
+}
+
+/**
+ * mpi3mr_alloc_fwevt - Allocate firmware event
+ * @len: length of firmware event data to allocate
+ *
+ * Allocate firmware event with required length and initialize
+ * the reference counter.
+ *
+ * Return: firmware event reference.
+ */
+static struct mpi3mr_fwevt *mpi3mr_alloc_fwevt(int len)
+{
+	struct mpi3mr_fwevt *fwevt;
+
+	fwevt = kzalloc(sizeof(*fwevt) + len, GFP_ATOMIC);
+	if (!fwevt)
+		return NULL;
+
+	kref_init(&fwevt->ref_count);
+	return fwevt;
+}
+
+/**
+ * mpi3mr_fwevt_add_to_list - Add firmware event to the list
+ * @mrioc: Adapter instance reference
+ * @fwevt: Firmware event reference
+ *
+ * Add the given firmware event to the firmware event list.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_fwevt_add_to_list(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_fwevt *fwevt)
+{
+	unsigned long flags;
+
+	if (!mrioc->fwevt_worker_thread)
+		return;
+
+	spin_lock_irqsave(&mrioc->fwevt_lock, flags);
+	/* get fwevt reference count while adding it to fwevt_list */
+	mpi3mr_fwevt_get(fwevt);
+	INIT_LIST_HEAD(&fwevt->list);
+	list_add_tail(&fwevt->list, &mrioc->fwevt_list);
+	INIT_WORK(&fwevt->work, mpi3mr_fwevt_worker);
+	/* get fwevt reference count while enqueueing it to worker queue */
+	mpi3mr_fwevt_get(fwevt);
+	queue_work(mrioc->fwevt_worker_thread, &fwevt->work);
+	spin_unlock_irqrestore(&mrioc->fwevt_lock, flags);
+}
+
+/**
+ * mpi3mr_fwevt_del_from_list - Delete firmware event from list
+ * @mrioc: Adapter instance reference
+ * @fwevt: Firmware event reference
+ *
+ * Delete the given firmware event from the firmware event list.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_fwevt_del_from_list(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_fwevt *fwevt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mrioc->fwevt_lock, flags);
+	if (!list_empty(&fwevt->list)) {
+		list_del_init(&fwevt->list);
+		/*
+		 * Put fwevt reference count after
+		 * removing it from fwevt_list
+		 */
+		mpi3mr_fwevt_put(fwevt);
+	}
+	spin_unlock_irqrestore(&mrioc->fwevt_lock, flags);
+}
+
+/**
+ * mpi3mr_dequeue_fwevt - Dequeue firmware event from the list
+ * @mrioc: Adapter instance reference
+ *
+ * Dequeue a firmware event from the firmware event list.
+ *
+ * Return: firmware event.
+ */
+static struct mpi3mr_fwevt *mpi3mr_dequeue_fwevt(
+	struct mpi3mr_ioc *mrioc)
+{
+	unsigned long flags;
+	struct mpi3mr_fwevt *fwevt = NULL;
+
+	spin_lock_irqsave(&mrioc->fwevt_lock, flags);
+	if (!list_empty(&mrioc->fwevt_list)) {
+		fwevt = list_first_entry(&mrioc->fwevt_list,
+		    struct mpi3mr_fwevt, list);
+		list_del_init(&fwevt->list);
+		/*
+		 * Put fwevt reference count after
+		 * removing it from fwevt_list
+		 */
+		mpi3mr_fwevt_put(fwevt);
+	}
+	spin_unlock_irqrestore(&mrioc->fwevt_lock, flags);
+
+	return fwevt;
+}
+
+/**
+ * mpi3mr_cleanup_fwevt_list - Cleanup firmware event list
+ * @mrioc: Adapter instance reference
+ *
+ * Flush all pending firmware events from the firmware event
+ * list.
+ *
+ * Return: Nothing.
+ */
+void mpi3mr_cleanup_fwevt_list(struct mpi3mr_ioc *mrioc)
+{
+	struct mpi3mr_fwevt *fwevt = NULL;
+
+	if ((list_empty(&mrioc->fwevt_list) && !mrioc->current_event) ||
+	    !mrioc->fwevt_worker_thread)
+		return;
+
+	while ((fwevt = mpi3mr_dequeue_fwevt(mrioc)) ||
+	    (fwevt = mrioc->current_event)) {
+		/*
+		 * Wait on the fwevt to complete. If this returns 1, then
+		 * the event was never executed, and we need a put for the
+		 * reference the work had on the fwevt.
+		 *
+		 * If it did execute, we wait for it to finish, and the put will
+		 * happen from mpi3mr_process_fwevt()
+		 */
+		if (cancel_work_sync(&fwevt->work)) {
+			/*
+			 * Put fwevt reference count after
+			 * dequeuing it from worker queue
+			 */
+			mpi3mr_fwevt_put(fwevt);
+			/*
+			 * Put fwevt reference count to neutralize
+			 * kref_init increment
+			 */
+			mpi3mr_fwevt_put(fwevt);
+		}
+	}
+}
+
+/**
+ * mpi3mr_alloc_tgtdev - target device allocator
+ *
+ * Allocate target device instance and initialize the reference
+ * count
+ *
+ * Return: target device instance.
+ */
+static struct mpi3mr_tgt_dev *mpi3mr_alloc_tgtdev(void)
+{
+	struct mpi3mr_tgt_dev *tgtdev;
+
+	tgtdev = kzalloc(sizeof(*tgtdev), GFP_ATOMIC);
+	if (!tgtdev)
+		return NULL;
+	kref_init(&tgtdev->ref_count);
+	return tgtdev;
+}
+
+/**
+ * mpi3mr_tgtdev_add_to_list -Add tgtdevice to the list
+ * @mrioc: Adapter instance reference
+ * @tgtdev: Target device
+ *
+ * Add the target device to the target device list
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_tgtdev_add_to_list(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_tgt_dev *tgtdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	mpi3mr_tgtdev_get(tgtdev);
+	INIT_LIST_HEAD(&tgtdev->list);
+	list_add_tail(&tgtdev->list, &mrioc->tgtdev_list);
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+}
+
+/**
+ * mpi3mr_tgtdev_del_from_list -Delete tgtdevice from the list
+ * @mrioc: Adapter instance reference
+ * @tgtdev: Target device
+ *
+ * Remove the target device from the target device list
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_tgtdev_del_from_list(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_tgt_dev *tgtdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	if (!list_empty(&tgtdev->list)) {
+		list_del_init(&tgtdev->list);
+		mpi3mr_tgtdev_put(tgtdev);
+	}
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+}
+
+/**
+ * __mpi3mr_get_tgtdev_by_handle -Get tgtdev from device handle
+ * @mrioc: Adapter instance reference
+ * @handle: Device handle
+ *
+ * Accessor to retrieve target device from the device handle.
+ * Non Lock version
+ *
+ * Return: Target device reference.
+ */
+static struct mpi3mr_tgt_dev  *__mpi3mr_get_tgtdev_by_handle(
+	struct mpi3mr_ioc *mrioc, u16 handle)
+{
+	struct mpi3mr_tgt_dev *tgtdev;
+
+	assert_spin_locked(&mrioc->tgtdev_lock);
+	list_for_each_entry(tgtdev, &mrioc->tgtdev_list, list)
+		if (tgtdev->dev_handle == handle)
+			goto found_tgtdev;
+	return NULL;
+
+found_tgtdev:
+	mpi3mr_tgtdev_get(tgtdev);
+	return tgtdev;
+}
+
+/**
+ * mpi3mr_get_tgtdev_by_handle -Get tgtdev from device handle
+ * @mrioc: Adapter instance reference
+ * @handle: Device handle
+ *
+ * Accessor to retrieve target device from the device handle.
+ * Lock version
+ *
+ * Return: Target device reference.
+ */
+static struct mpi3mr_tgt_dev *mpi3mr_get_tgtdev_by_handle(
+	struct mpi3mr_ioc *mrioc, u16 handle)
+{
+	struct mpi3mr_tgt_dev *tgtdev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	tgtdev = __mpi3mr_get_tgtdev_by_handle(mrioc, handle);
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+	return tgtdev;
+}
+
+/**
+ * __mpi3mr_get_tgtdev_by_perst_id -Get tgtdev from persist ID
+ * @mrioc: Adapter instance reference
+ * @persist_id: Persistent ID
+ *
+ * Accessor to retrieve target device from the Persistent ID.
+ * Non Lock version
+ *
+ * Return: Target device reference.
+ */
+static struct mpi3mr_tgt_dev  *__mpi3mr_get_tgtdev_by_perst_id(
+	struct mpi3mr_ioc *mrioc, u16 persist_id)
+{
+	struct mpi3mr_tgt_dev *tgtdev;
+
+	assert_spin_locked(&mrioc->tgtdev_lock);
+	list_for_each_entry(tgtdev, &mrioc->tgtdev_list, list)
+		if (tgtdev->perst_id == persist_id)
+			goto found_tgtdev;
+	return NULL;
+
+found_tgtdev:
+	mpi3mr_tgtdev_get(tgtdev);
+	return tgtdev;
+}
+
+/**
+ * mpi3mr_get_tgtdev_by_perst_id -Get tgtdev from persistent ID
+ * @mrioc: Adapter instance reference
+ * @persist_id: Persistent ID
+ *
+ * Accessor to retrieve target device from the Persistent ID.
+ * Lock version
+ *
+ * Return: Target device reference.
+ */
+static struct mpi3mr_tgt_dev *mpi3mr_get_tgtdev_by_perst_id(
+	struct mpi3mr_ioc *mrioc, u16 persist_id)
+{
+	struct mpi3mr_tgt_dev *tgtdev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	tgtdev = __mpi3mr_get_tgtdev_by_perst_id(mrioc, persist_id);
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+	return tgtdev;
+}
+
+/**
+ * __mpi3mr_get_tgtdev_from_tgtpriv -Get tgtdev from tgt private
+ * @mrioc: Adapter instance reference
+ * @tgt_priv: Target private data
+ *
+ * Accessor to return target device from the target private
+ * data. Non Lock version
+ *
+ * Return: Target device reference.
+ */
+static struct mpi3mr_tgt_dev  *__mpi3mr_get_tgtdev_from_tgtpriv(
+	struct mpi3mr_ioc *mrioc, struct mpi3mr_stgt_priv_data *tgt_priv)
+{
+	struct mpi3mr_tgt_dev *tgtdev;
+
+	assert_spin_locked(&mrioc->tgtdev_lock);
+	tgtdev = tgt_priv->tgt_dev;
+	if (tgtdev)
+		mpi3mr_tgtdev_get(tgtdev);
+	return tgtdev;
+}
+
+/**
+ * mpi3mr_remove_tgtdev_from_host - Remove dev from upper layers
+ * @mrioc: Adapter instance reference
+ * @tgtdev: Target device structure
+ *
+ * Checks whether the device is exposed to upper layers and if it
+ * is then remove the device from upper layers by calling
+ * scsi_remove_target().
+ *
+ * Return: 0 on success, non zero on failure.
+ */
+static void mpi3mr_remove_tgtdev_from_host(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_tgt_dev *tgtdev)
+{
+	struct mpi3mr_stgt_priv_data *tgt_priv;
+
+	ioc_info(mrioc, "%s :Removing handle(0x%04x), wwid(0x%016llx)\n",
+	    __func__, tgtdev->dev_handle, (unsigned long long)tgtdev->wwid);
+	if (tgtdev->starget && tgtdev->starget->hostdata) {
+		tgt_priv = tgtdev->starget->hostdata;
+		tgt_priv->dev_handle = MPI3MR_INVALID_DEV_HANDLE;
+	}
+
+	if (tgtdev->starget) {
+		scsi_remove_target(&tgtdev->starget->dev);
+		tgtdev->host_exposed = 0;
+	}
+	ioc_info(mrioc, "%s :Removed handle(0x%04x), wwid(0x%016llx)\n",
+	    __func__, tgtdev->dev_handle, (unsigned long long)tgtdev->wwid);
+}
+
+/**
+ * mpi3mr_report_tgtdev_to_host - Expose device to upper layers
+ * @mrioc: Adapter instance reference
+ * @perst_id: Persistent ID of the device
+ *
+ * Checks whether the device can be exposed to upper layers and
+ * if it is not then expose the device to upper layers by
+ * calling scsi_scan_target().
+ *
+ * Return: 0 on success, non zero on failure.
+ */
+static int mpi3mr_report_tgtdev_to_host(struct mpi3mr_ioc *mrioc,
+	u16 perst_id)
+{
+	int retval = 0;
+	struct mpi3mr_tgt_dev *tgtdev;
+
+	tgtdev = mpi3mr_get_tgtdev_by_perst_id(mrioc, perst_id);
+	if (!tgtdev) {
+		retval = -1;
+		goto out;
+	}
+	if (tgtdev->is_hidden) {
+		retval = -1;
+		goto out;
+	}
+	if (!tgtdev->host_exposed && !mrioc->reset_in_progress) {
+		tgtdev->host_exposed = 1;
+		scsi_scan_target(&mrioc->shost->shost_gendev, 0,
+		    tgtdev->perst_id,
+		    SCAN_WILD_CARD, SCSI_SCAN_INITIAL);
+		if (!tgtdev->starget)
+			tgtdev->host_exposed = 0;
+	}
+out:
+	if (tgtdev)
+		mpi3mr_tgtdev_put(tgtdev);
+
+	return retval;
+}
+
+/**
+ * mpi3mr_rfresh_tgtdevs - Refresh target device exposure
+ * @mrioc: Adapter instance reference
+ *
+ * This is executed post controller reset to identify any
+ * missing devices during reset and remove from the upper layers
+ * or expose any newly detected device to the upper layers.
+ *
+ * Return: Nothing.
+ */
+
+void mpi3mr_rfresh_tgtdevs(struct mpi3mr_ioc *mrioc)
+{
+	struct mpi3mr_tgt_dev *tgtdev, *tgtdev_next;
+
+	list_for_each_entry_safe(tgtdev, tgtdev_next, &mrioc->tgtdev_list,
+	    list) {
+		if ((tgtdev->dev_handle == MPI3MR_INVALID_DEV_HANDLE) &&
+		    tgtdev->host_exposed) {
+			mpi3mr_remove_tgtdev_from_host(mrioc, tgtdev);
+			mpi3mr_tgtdev_del_from_list(mrioc, tgtdev);
+			mpi3mr_tgtdev_put(tgtdev);
+		}
+	}
+
+	tgtdev = NULL;
+	list_for_each_entry(tgtdev, &mrioc->tgtdev_list, list) {
+		if ((tgtdev->dev_handle != MPI3MR_INVALID_DEV_HANDLE) &&
+		    !tgtdev->is_hidden && !tgtdev->host_exposed)
+			mpi3mr_report_tgtdev_to_host(mrioc, tgtdev->perst_id);
+	}
+}
+
+/**
+ * mpi3mr_update_tgtdev - DevStatusChange evt bottomhalf
+ * @mrioc: Adapter instance reference
+ * @tgtdev: Target device internal structure
+ * @dev_pg0: New device page0
+ *
+ * Update the information from the device page0 into the driver
+ * cached target device structure.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_update_tgtdev(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_tgt_dev *tgtdev, struct _mpi3_device_page0 *dev_pg0)
+{
+	u16 flags = 0;
+	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data;
+
+	tgtdev->perst_id = le16_to_cpu(dev_pg0->persistent_id);
+	tgtdev->dev_handle = le16_to_cpu(dev_pg0->dev_handle);
+	tgtdev->dev_type = dev_pg0->device_form;
+	tgtdev->encl_handle = le16_to_cpu(dev_pg0->enclosure_handle);
+	tgtdev->parent_handle = le16_to_cpu(dev_pg0->parent_dev_handle);
+	tgtdev->slot = le16_to_cpu(dev_pg0->slot);
+	tgtdev->q_depth = le16_to_cpu(dev_pg0->queue_depth);
+	tgtdev->wwid = le64_to_cpu(dev_pg0->wwid);
+
+	flags = le16_to_cpu(dev_pg0->flags);
+	tgtdev->is_hidden = (flags & MPI3_DEVICE0_FLAGS_HIDDEN);
+
+	if (tgtdev->starget && tgtdev->starget->hostdata) {
+		scsi_tgt_priv_data = (struct mpi3mr_stgt_priv_data *)
+		    tgtdev->starget->hostdata;
+		scsi_tgt_priv_data->perst_id = tgtdev->perst_id;
+		scsi_tgt_priv_data->dev_handle = tgtdev->dev_handle;
+		scsi_tgt_priv_data->dev_type = tgtdev->dev_type;
+	}
+
+	switch (tgtdev->dev_type) {
+	case MPI3_DEVICE_DEVFORM_SAS_SATA:
+	{
+		struct _mpi3_device0_sas_sata_format *sasinf =
+		    &dev_pg0->device_specific.sas_sata_format;
+		u16 dev_info = le16_to_cpu(sasinf->device_info);
+
+		tgtdev->dev_spec.sas_sata_inf.dev_info = dev_info;
+		tgtdev->dev_spec.sas_sata_inf.sas_address =
+		    le64_to_cpu(sasinf->sas_address);
+		if ((dev_info & MPI3_SAS_DEVICE_INFO_DEVICE_TYPE_MASK) !=
+		    MPI3_SAS_DEVICE_INFO_DEVICE_TYPE_END_DEVICE)
+			tgtdev->is_hidden = 1;
+		else if (!(dev_info & (MPI3_SAS_DEVICE_INFO_STP_SATA_TARGET |
+		    MPI3_SAS_DEVICE_INFO_SSP_TARGET)))
+			tgtdev->is_hidden = 1;
+		break;
+	}
+	case MPI3_DEVICE_DEVFORM_VD:
+	{
+		struct _mpi3_device0_vd_format *vdinf =
+		    &dev_pg0->device_specific.vd_format;
+
+		tgtdev->dev_spec.vol_inf.state = vdinf->vd_state;
+		if (vdinf->vd_state == MPI3_DEVICE0_VD_STATE_OFFLINE)
+			tgtdev->is_hidden = 1;
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+/**
+ * mpi3mr_devstatuschg_evt_bh - DevStatusChange evt bottomhalf
+ * @mrioc: Adapter instance reference
+ * @fwevt: Firmware event information.
+ *
+ * Process Device status Change event and based on device's new
+ * information, either expose the device to the upper layers, or
+ * remove the device from upper layers.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_devstatuschg_evt_bh(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_fwevt *fwevt)
+{
+	u16 dev_handle = 0;
+	u8 uhide = 0, delete = 0, cleanup = 0;
+	struct mpi3mr_tgt_dev *tgtdev = NULL;
+	struct _mpi3_event_data_device_status_change *evtdata =
+	    (struct _mpi3_event_data_device_status_change *)fwevt->event_data;
+
+	dev_handle = le16_to_cpu(evtdata->dev_handle);
+	ioc_info(mrioc,
+	    "%s :device status change: handle(0x%04x): reason code(0x%x)\n",
+	    __func__, dev_handle, evtdata->reason_code);
+	switch (evtdata->reason_code) {
+	case MPI3_EVENT_DEV_STAT_RC_HIDDEN:
+		delete = 1;
+		break;
+	case MPI3_EVENT_DEV_STAT_RC_NOT_HIDDEN:
+		uhide = 1;
+		break;
+	case MPI3_EVENT_DEV_STAT_RC_VD_NOT_RESPONDING:
+		delete = 1;
+		cleanup = 1;
+		break;
+	default:
+		ioc_info(mrioc, "%s :Unhandled reason code(0x%x)\n", __func__,
+		    evtdata->reason_code);
+		break;
+	}
+
+	tgtdev = mpi3mr_get_tgtdev_by_handle(mrioc, dev_handle);
+	if (!tgtdev)
+		goto out;
+	if (uhide) {
+		tgtdev->is_hidden = 0;
+		if (!tgtdev->host_exposed)
+			mpi3mr_report_tgtdev_to_host(mrioc, tgtdev->perst_id);
+	}
+	if (tgtdev->starget && tgtdev->starget->hostdata) {
+		if (delete)
+			mpi3mr_remove_tgtdev_from_host(mrioc, tgtdev);
+	}
+	if (cleanup) {
+		mpi3mr_tgtdev_del_from_list(mrioc, tgtdev);
+		mpi3mr_tgtdev_put(tgtdev);
+	}
+
+out:
+	if (tgtdev)
+		mpi3mr_tgtdev_put(tgtdev);
+}
+
+/**
+ * mpi3mr_devinfochg_evt_bh - DeviceInfoChange evt bottomhalf
+ * @mrioc: Adapter instance reference
+ * @dev_pg0: New device page0
+ *
+ * Process Device Info Change event and based on device's new
+ * information, either expose the device to the upper layers, or
+ * remove the device from upper layers or update the details of
+ * the device.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_devinfochg_evt_bh(struct mpi3mr_ioc *mrioc,
+	struct _mpi3_device_page0 *dev_pg0)
+{
+	struct mpi3mr_tgt_dev *tgtdev = NULL;
+	u16 dev_handle = 0, perst_id = 0;
+
+	perst_id = le16_to_cpu(dev_pg0->persistent_id);
+	dev_handle = le16_to_cpu(dev_pg0->dev_handle);
+	ioc_info(mrioc,
+	    "%s :Device info change: handle(0x%04x): persist_id(0x%x)\n",
+	    __func__, dev_handle, perst_id);
+	tgtdev = mpi3mr_get_tgtdev_by_handle(mrioc, dev_handle);
+	if (!tgtdev)
+		goto out;
+	mpi3mr_update_tgtdev(mrioc, tgtdev, dev_pg0);
+	if (!tgtdev->is_hidden && !tgtdev->host_exposed)
+		mpi3mr_report_tgtdev_to_host(mrioc, perst_id);
+	if (tgtdev->is_hidden && tgtdev->host_exposed)
+		mpi3mr_remove_tgtdev_from_host(mrioc, tgtdev);
+out:
+	if (tgtdev)
+		mpi3mr_tgtdev_put(tgtdev);
+}
+
+/**
+ * mpi3mr_sastopochg_evt_bh - SASTopologyChange evt bottomhalf
+ * @mrioc: Adapter instance reference
+ * @fwevt: Firmware event reference
+ *
+ * Prints information about the SAS topology change event and
+ * for "not responding" event code, removes the device from the
+ * upper layers.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_sastopochg_evt_bh(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_fwevt *fwevt)
+{
+	struct _mpi3_event_data_sas_topology_change_list *event_data =
+	    (struct _mpi3_event_data_sas_topology_change_list *)fwevt->event_data;
+	int i;
+	u16 handle;
+	u8 reason_code;
+	struct mpi3mr_tgt_dev *tgtdev = NULL;
+
+	for (i = 0; i < event_data->num_entries; i++) {
+		handle = le16_to_cpu(event_data->phy_entry[i].attached_dev_handle);
+		if (!handle)
+			continue;
+		tgtdev = mpi3mr_get_tgtdev_by_handle(mrioc, handle);
+		if (!tgtdev)
+			continue;
+
+		reason_code = event_data->phy_entry[i].status &
+		    MPI3_EVENT_SAS_TOPO_PHY_RC_MASK;
+
+		switch (reason_code) {
+		case MPI3_EVENT_SAS_TOPO_PHY_RC_TARG_NOT_RESPONDING:
+			if (tgtdev->host_exposed)
+				mpi3mr_remove_tgtdev_from_host(mrioc, tgtdev);
+			mpi3mr_tgtdev_del_from_list(mrioc, tgtdev);
+			mpi3mr_tgtdev_put(tgtdev);
+			break;
+		default:
+			break;
+		}
+		if (tgtdev)
+			mpi3mr_tgtdev_put(tgtdev);
+	}
+}
+
+/**
+ * mpi3mr_fwevt_bh - Firmware event bottomhalf handler
+ * @mrioc: Adapter instance reference
+ * @fwevt: Firmware event reference
+ *
+ * Identifies the firmware event and calls corresponding bottomg
+ * half handler and sends event acknowledgment if required.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_fwevt_bh(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_fwevt *fwevt)
+{
+	mrioc->current_event = fwevt;
+	mpi3mr_fwevt_del_from_list(mrioc, fwevt);
+
+	if (mrioc->stop_drv_processing)
+		goto out;
+
+	if (!fwevt->process_evt)
+		goto evt_ack;
+
+	switch (fwevt->event_id) {
+	case MPI3_EVENT_DEVICE_ADDED:
+	{
+		struct _mpi3_device_page0 *dev_pg0 =
+		    (struct _mpi3_device_page0 *)fwevt->event_data;
+		mpi3mr_report_tgtdev_to_host(mrioc,
+		    le16_to_cpu(dev_pg0->persistent_id));
+		break;
+	}
+	case MPI3_EVENT_DEVICE_INFO_CHANGED:
+	{
+		mpi3mr_devinfochg_evt_bh(mrioc,
+		    (struct _mpi3_device_page0 *)fwevt->event_data);
+		break;
+	}
+	case MPI3_EVENT_DEVICE_STATUS_CHANGE:
+	{
+		mpi3mr_devstatuschg_evt_bh(mrioc, fwevt);
+		break;
+	}
+	case MPI3_EVENT_SAS_TOPOLOGY_CHANGE_LIST:
+	{
+		mpi3mr_sastopochg_evt_bh(mrioc, fwevt);
+		break;
+	}
+	default:
+		break;
+	}
+
+evt_ack:
+	if (fwevt->send_ack)
+		mpi3mr_send_event_ack(mrioc, fwevt->event_id,
+		    fwevt->evt_ctx);
+out:
+	/* Put fwevt reference count to neutralize kref_init increment */
+	mpi3mr_fwevt_put(fwevt);
+	mrioc->current_event = NULL;
+}
+
+/**
+ * mpi3mr_fwevt_worker - Firmware event worker
+ * @work: Work struct containing firmware event
+ *
+ * Extracts the firmware event and calls mpi3mr_fwevt_bh.
+ *
+ * Return: Nothing.
+ */
+static void mpi3mr_fwevt_worker(struct work_struct *work)
+{
+	struct mpi3mr_fwevt *fwevt = container_of(work, struct mpi3mr_fwevt,
+	    work);
+	mpi3mr_fwevt_bh(fwevt->mrioc, fwevt);
+	/*
+	 * Put fwevt reference count after
+	 * dequeuing it from worker queue
+	 */
+	mpi3mr_fwevt_put(fwevt);
+}
+
+/**
+ * mpi3mr_create_tgtdev - Create and add a target device
+ * @mrioc: Adapter instance reference
+ * @dev_pg0: Device Page 0 data
+ *
+ * If the device specified by the device page 0 data is not
+ * present in the driver's internal list, allocate the memory
+ * for the device, populate the data and add to the list, else
+ * update the device data.  The key is persistent ID.
+ *
+ * Return: 0 on success, -ENOMEM on memory allocation failure
+ */
+static int mpi3mr_create_tgtdev(struct mpi3mr_ioc *mrioc,
+	struct _mpi3_device_page0 *dev_pg0)
+{
+	int retval = 0;
+	struct mpi3mr_tgt_dev *tgtdev = NULL;
+	u16 perst_id = 0;
+
+	perst_id = le16_to_cpu(dev_pg0->persistent_id);
+	tgtdev = mpi3mr_get_tgtdev_by_perst_id(mrioc, perst_id);
+	if (tgtdev) {
+		mpi3mr_update_tgtdev(mrioc, tgtdev, dev_pg0);
+		mpi3mr_tgtdev_put(tgtdev);
+	} else {
+		tgtdev = mpi3mr_alloc_tgtdev();
+		if (!tgtdev)
+			return -ENOMEM;
+		mpi3mr_update_tgtdev(mrioc, tgtdev, dev_pg0);
+		mpi3mr_tgtdev_add_to_list(mrioc, tgtdev);
+	}
+
+	return retval;
+}
+
+/**
+ * mpi3mr_flush_delayed_rmhs_list - Flush pending commands
+ * @mrioc: Adapter instance reference
+ *
+ * Flush pending commands in the delayed removal handshake list
+ * due to a controller reset or driver removal as a cleanup.
+ *
+ * Return: Nothing
+ */
+void mpi3mr_flush_delayed_rmhs_list(struct mpi3mr_ioc *mrioc)
+{
+	struct delayed_dev_rmhs_node *_rmhs_node;
+
+	while (!list_empty(&mrioc->delayed_rmhs_list)) {
+		_rmhs_node = list_entry(mrioc->delayed_rmhs_list.next,
+		    struct delayed_dev_rmhs_node, list);
+		list_del(&_rmhs_node->list);
+		kfree(_rmhs_node);
+	}
+}
+
+/**
+ * mpi3mr_dev_rmhs_complete_iou - Device removal IOUC completion
+ * @mrioc: Adapter instance reference
+ * @drv_cmd: Internal command tracker
+ *
+ * Issues a target reset TM to the firmware from the device
+ * removal TM pend list or retry the removal handshake sequence
+ * based on the IOU control request IOC status.
+ *
+ * Return: Nothing
+ */
+static void mpi3mr_dev_rmhs_complete_iou(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_drv_cmd *drv_cmd)
+{
+	u16 cmd_idx = drv_cmd->host_tag - MPI3MR_HOSTTAG_DEVRMCMD_MIN;
+	struct delayed_dev_rmhs_node *delayed_dev_rmhs = NULL;
+
+	ioc_info(mrioc,
+	    "%s :dev_rmhs_iouctrl_complete:handle(0x%04x), ioc_status(0x%04x), loginfo(0x%08x)\n",
+	    __func__, drv_cmd->dev_handle, drv_cmd->ioc_status,
+	    drv_cmd->ioc_loginfo);
+	if (drv_cmd->ioc_status != MPI3_IOCSTATUS_SUCCESS) {
+		if (drv_cmd->retry_count < MPI3MR_DEV_RMHS_RETRY_COUNT) {
+			drv_cmd->retry_count++;
+			ioc_info(mrioc,
+			    "%s :dev_rmhs_iouctrl_complete: handle(0x%04x)retrying handshake retry=%d\n",
+			    __func__, drv_cmd->dev_handle,
+			    drv_cmd->retry_count);
+			mpi3mr_dev_rmhs_send_tm(mrioc, drv_cmd->dev_handle,
+			    drv_cmd, drv_cmd->iou_rc);
+			return;
+		}
+		ioc_err(mrioc,
+		    "%s :dev removal handshake failed after all retries: handle(0x%04x)\n",
+		    __func__, drv_cmd->dev_handle);
+	} else {
+		ioc_info(mrioc,
+		    "%s :dev removal handshake completed successfully: handle(0x%04x)\n",
+		    __func__, drv_cmd->dev_handle);
+		clear_bit(drv_cmd->dev_handle, mrioc->removepend_bitmap);
+	}
+
+	if (!list_empty(&mrioc->delayed_rmhs_list)) {
+		delayed_dev_rmhs = list_entry(mrioc->delayed_rmhs_list.next,
+		    struct delayed_dev_rmhs_node, list);
+		drv_cmd->dev_handle = delayed_dev_rmhs->handle;
+		drv_cmd->retry_count = 0;
+		drv_cmd->iou_rc = delayed_dev_rmhs->iou_rc;
+		ioc_info(mrioc,
+		    "%s :dev_rmhs_iouctrl_complete: processing delayed TM: handle(0x%04x)\n",
+		    __func__, drv_cmd->dev_handle);
+		mpi3mr_dev_rmhs_send_tm(mrioc, drv_cmd->dev_handle, drv_cmd,
+		    drv_cmd->iou_rc);
+		list_del(&delayed_dev_rmhs->list);
+		kfree(delayed_dev_rmhs);
+		return;
+	}
+	drv_cmd->state = MPI3MR_CMD_NOTUSED;
+	drv_cmd->callback = NULL;
+	drv_cmd->retry_count = 0;
+	drv_cmd->dev_handle = MPI3MR_INVALID_DEV_HANDLE;
+	clear_bit(cmd_idx, mrioc->devrem_bitmap);
+}
+
+/**
+ * mpi3mr_dev_rmhs_complete_tm - Device removal TM completion
+ * @mrioc: Adapter instance reference
+ * @drv_cmd: Internal command tracker
+ *
+ * Issues a target reset TM to the firmware from the device
+ * removal TM pend list or issue IO unit control request as
+ * part of device removal or hidden acknowledgment handshake.
+ *
+ * Return: Nothing
+ */
+static void mpi3mr_dev_rmhs_complete_tm(struct mpi3mr_ioc *mrioc,
+	struct mpi3mr_drv_cmd *drv_cmd)
+{
+	struct _mpi3_iounit_control_request iou_ctrl;
+	u16 cmd_idx = drv_cmd->host_tag - MPI3MR_HOSTTAG_DEVRMCMD_MIN;
+	struct _mpi3_scsi_task_mgmt_reply *tm_reply = NULL;
+	int retval;
+
+	if (drv_cmd->state & MPI3MR_CMD_REPLY_VALID)
+		tm_reply = (struct _mpi3_scsi_task_mgmt_reply *)drv_cmd->reply;
+
+	if (tm_reply)
+		pr_info(IOCNAME
+		    "dev_rmhs_tr_complete:handle(0x%04x), ioc_status(0x%04x), loginfo(0x%08x), term_count(%d)\n",
+		    mrioc->name, drv_cmd->dev_handle, drv_cmd->ioc_status,
+		    drv_cmd->ioc_loginfo,
+		    le32_to_cpu(tm_reply->termination_count));
+
+	pr_info(IOCNAME "Issuing IOU CTL: handle(0x%04x) dev_rmhs idx(%d)\n",
+	    mrioc->name, drv_cmd->dev_handle, cmd_idx);
+
+	memset(&iou_ctrl, 0, sizeof(iou_ctrl));
+
+	drv_cmd->state = MPI3MR_CMD_PENDING;
+	drv_cmd->is_waiting = 0;
+	drv_cmd->callback = mpi3mr_dev_rmhs_complete_iou;
+	iou_ctrl.operation = drv_cmd->iou_rc;
+	iou_ctrl.param16[0] = cpu_to_le16(drv_cmd->dev_handle);
+	iou_ctrl.host_tag = cpu_to_le16(drv_cmd->host_tag);
+	iou_ctrl.function = MPI3_FUNCTION_IO_UNIT_CONTROL;
+
+	retval = mpi3mr_admin_request_post(mrioc, &iou_ctrl, sizeof(iou_ctrl),
+	    1);
+	if (retval) {
+		pr_err(IOCNAME "Issue DevRmHsTMIOUCTL: Admin post failed\n",
+		    mrioc->name);
+		goto out_failed;
+	}
+
+	return;
+out_failed:
+	drv_cmd->state = MPI3MR_CMD_NOTUSED;
+	drv_cmd->callback = NULL;
+	drv_cmd->dev_handle = MPI3MR_INVALID_DEV_HANDLE;
+	drv_cmd->retry_count = 0;
+	clear_bit(cmd_idx, mrioc->devrem_bitmap);
+}
+
+/**
+ * mpi3mr_dev_rmhs_send_tm - Issue TM for device removal
+ * @mrioc: Adapter instance reference
+ * @handle: Device handle
+ * @cmdparam: Internal command tracker
+ * @iou_rc: IO unit reason code
+ *
+ * Issues a target reset TM to the firmware or add it to a pend
+ * list as part of device removal or hidden acknowledgment
+ * handshake.
+ *
+ * Return: Nothing
+ */
+static void mpi3mr_dev_rmhs_send_tm(struct mpi3mr_ioc *mrioc, u16 handle,
+	struct mpi3mr_drv_cmd *cmdparam, u8 iou_rc)
+{
+	struct _mpi3_scsi_task_mgmt_request tm_req;
+	int retval = 0;
+	u16 cmd_idx = MPI3MR_NUM_DEVRMCMD;
+	u8 retrycount = 5;
+	struct mpi3mr_drv_cmd *drv_cmd = cmdparam;
+	struct delayed_dev_rmhs_node *delayed_dev_rmhs = NULL;
+
+	if (drv_cmd)
+		goto issue_cmd;
+	do {
+		cmd_idx = find_first_zero_bit(mrioc->devrem_bitmap,
+		    MPI3MR_NUM_DEVRMCMD);
+		if (cmd_idx < MPI3MR_NUM_DEVRMCMD) {
+			if (!test_and_set_bit(cmd_idx, mrioc->devrem_bitmap))
+				break;
+			cmd_idx = MPI3MR_NUM_DEVRMCMD;
+		}
+	} while (retrycount--);
+
+	if (cmd_idx >= MPI3MR_NUM_DEVRMCMD) {
+		delayed_dev_rmhs = kzalloc(sizeof(*delayed_dev_rmhs),
+		    GFP_ATOMIC);
+		if (!delayed_dev_rmhs)
+			return;
+		INIT_LIST_HEAD(&delayed_dev_rmhs->list);
+		delayed_dev_rmhs->handle = handle;
+		delayed_dev_rmhs->iou_rc = iou_rc;
+		list_add_tail(&delayed_dev_rmhs->list,
+		    &mrioc->delayed_rmhs_list);
+		ioc_info(mrioc, "%s :DevRmHs: tr:handle(0x%04x) is postponed\n",
+		    __func__, handle);
+		return;
+	}
+	drv_cmd = &mrioc->dev_rmhs_cmds[cmd_idx];
+
+issue_cmd:
+	cmd_idx = drv_cmd->host_tag - MPI3MR_HOSTTAG_DEVRMCMD_MIN;
+	ioc_info(mrioc,
+	    "%s :Issuing TR TM: for devhandle 0x%04x with dev_rmhs %d\n",
+	    __func__, handle, cmd_idx);
+
+	memset(&tm_req, 0, sizeof(tm_req));
+	if (drv_cmd->state & MPI3MR_CMD_PENDING) {
+		ioc_err(mrioc, "%s :Issue TM: Command is in use\n", __func__);
+		goto out;
+	}
+	drv_cmd->state = MPI3MR_CMD_PENDING;
+	drv_cmd->is_waiting = 0;
+	drv_cmd->callback = mpi3mr_dev_rmhs_complete_tm;
+	drv_cmd->dev_handle = handle;
+	drv_cmd->iou_rc = iou_rc;
+	tm_req.dev_handle = cpu_to_le16(handle);
+	tm_req.task_type = MPI3_SCSITASKMGMT_TASKTYPE_TARGET_RESET;
+	tm_req.host_tag = cpu_to_le16(drv_cmd->host_tag);
+	tm_req.task_host_tag = cpu_to_le16(MPI3MR_HOSTTAG_INVALID);
+	tm_req.function = MPI3_FUNCTION_SCSI_TASK_MGMT;
+
+	set_bit(handle, mrioc->removepend_bitmap);
+	retval = mpi3mr_admin_request_post(mrioc, &tm_req, sizeof(tm_req), 1);
+	if (retval) {
+		ioc_err(mrioc, "%s :Issue DevRmHsTM: Admin Post failed\n",
+		    __func__);
+		goto out_failed;
+	}
+out:
+	return;
+out_failed:
+	drv_cmd->state = MPI3MR_CMD_NOTUSED;
+	drv_cmd->callback = NULL;
+	drv_cmd->dev_handle = MPI3MR_INVALID_DEV_HANDLE;
+	drv_cmd->retry_count = 0;
+	clear_bit(cmd_idx, mrioc->devrem_bitmap);
+}
+
+/**
+ * mpi3mr_sastopochg_evt_th - SASTopologyChange evt tophalf
+ * @mrioc: Adapter instance reference
+ * @event_reply: event data
+ *
+ * Checks for the reason code and based on that either block I/O
+ * to device, or unblock I/O to the device, or start the device
+ * removal handshake with reason as remove with the firmware for
+ * SAS/SATA devices.
+ *
+ * Return: Nothing
+ */
+static void mpi3mr_sastopochg_evt_th(struct mpi3mr_ioc *mrioc,
+	struct _mpi3_event_notification_reply *event_reply)
+{
+	struct _mpi3_event_data_sas_topology_change_list *topo_evt =
+	    (struct _mpi3_event_data_sas_topology_change_list *)event_reply->event_data;
+	int i;
+	u16 handle;
+	u8 reason_code;
+	struct mpi3mr_tgt_dev *tgtdev = NULL;
+	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data = NULL;
+
+	for (i = 0; i < topo_evt->num_entries; i++) {
+		handle = le16_to_cpu(topo_evt->phy_entry[i].attached_dev_handle);
+		if (!handle)
+			continue;
+		reason_code = topo_evt->phy_entry[i].status &
+		    MPI3_EVENT_SAS_TOPO_PHY_RC_MASK;
+		scsi_tgt_priv_data =  NULL;
+		tgtdev = mpi3mr_get_tgtdev_by_handle(mrioc, handle);
+		if (tgtdev && tgtdev->starget && tgtdev->starget->hostdata)
+			scsi_tgt_priv_data = (struct mpi3mr_stgt_priv_data *)
+			    tgtdev->starget->hostdata;
+		switch (reason_code) {
+		case MPI3_EVENT_SAS_TOPO_PHY_RC_TARG_NOT_RESPONDING:
+			if (scsi_tgt_priv_data) {
+				scsi_tgt_priv_data->dev_removed = 1;
+				scsi_tgt_priv_data->dev_removedelay = 0;
+				atomic_set(&scsi_tgt_priv_data->block_io, 0);
+			}
+			mpi3mr_dev_rmhs_send_tm(mrioc, handle, NULL,
+			    MPI3_CTRL_OP_REMOVE_DEVICE);
+			break;
+		case MPI3_EVENT_SAS_TOPO_PHY_RC_DELAY_NOT_RESPONDING:
+			if (scsi_tgt_priv_data) {
+				scsi_tgt_priv_data->dev_removedelay = 1;
+				atomic_inc(&scsi_tgt_priv_data->block_io);
+			}
+			break;
+		case MPI3_EVENT_SAS_TOPO_PHY_RC_RESPONDING:
+			if (scsi_tgt_priv_data &&
+			    scsi_tgt_priv_data->dev_removedelay) {
+				scsi_tgt_priv_data->dev_removedelay = 0;
+				atomic_dec_if_positive
+				    (&scsi_tgt_priv_data->block_io);
+			}
+		case MPI3_EVENT_SAS_TOPO_PHY_RC_PHY_CHANGED:
+		default:
+			break;
+		}
+		if (tgtdev)
+			mpi3mr_tgtdev_put(tgtdev);
+	}
+}
+
+/**
+ * mpi3mr_devstatuschg_evt_th - DeviceStatusChange evt tophalf
+ * @mrioc: Adapter instance reference
+ * @event_reply: event data
+ *
+ * Checks for the reason code and based on that either block I/O
+ * to device, or unblock I/O to the device, or start the device
+ * removal handshake with reason as remove/hide acknowledgment
+ * with the firmware.
+ *
+ * Return: Nothing
+ */
+static void mpi3mr_devstatuschg_evt_th(struct mpi3mr_ioc *mrioc,
+	struct _mpi3_event_notification_reply *event_reply)
+{
+	u16 dev_handle = 0;
+	u8 ublock = 0, block = 0, hide = 0, delete = 0, remove = 0;
+	struct mpi3mr_tgt_dev *tgtdev = NULL;
+	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data = NULL;
+	struct _mpi3_event_data_device_status_change *evtdata =
+	    (struct _mpi3_event_data_device_status_change *)event_reply->event_data;
+
+	if (mrioc->stop_drv_processing)
+		goto out;
+
+	dev_handle = le16_to_cpu(evtdata->dev_handle);
+
+	switch (evtdata->reason_code) {
+	case MPI3_EVENT_DEV_STAT_RC_INT_DEVICE_RESET_STRT:
+	case MPI3_EVENT_DEV_STAT_RC_INT_IT_NEXUS_RESET_STRT:
+		block = 1;
+		break;
+	case MPI3_EVENT_DEV_STAT_RC_HIDDEN:
+		delete = 1;
+		hide = 1;
+		break;
+	case MPI3_EVENT_DEV_STAT_RC_VD_NOT_RESPONDING:
+		delete = 1;
+		remove = 1;
+		break;
+	case MPI3_EVENT_DEV_STAT_RC_INT_DEVICE_RESET_CMP:
+	case MPI3_EVENT_DEV_STAT_RC_INT_IT_NEXUS_RESET_CMP:
+		ublock = 1;
+		break;
+	default:
+		break;
+	}
+
+	tgtdev = mpi3mr_get_tgtdev_by_handle(mrioc, dev_handle);
+	if (!tgtdev)
+		goto out;
+	if (hide)
+		tgtdev->is_hidden = hide;
+	if (tgtdev->starget && tgtdev->starget->hostdata) {
+		scsi_tgt_priv_data = (struct mpi3mr_stgt_priv_data *)
+		    tgtdev->starget->hostdata;
+		if (block)
+			atomic_inc(&scsi_tgt_priv_data->block_io);
+		if (delete)
+			scsi_tgt_priv_data->dev_removed = 1;
+		if (ublock)
+			atomic_dec_if_positive(&scsi_tgt_priv_data->block_io);
+	}
+	if (remove)
+		mpi3mr_dev_rmhs_send_tm(mrioc, dev_handle, NULL,
+		    MPI3_CTRL_OP_REMOVE_DEVICE);
+	if (hide)
+		mpi3mr_dev_rmhs_send_tm(mrioc, dev_handle, NULL,
+		    MPI3_CTRL_OP_HIDDEN_ACK);
+
+out:
+	if (tgtdev)
+		mpi3mr_tgtdev_put(tgtdev);
+}
+
+/**
+ * mpi3mr_os_handle_events - Firmware event handler
+ * @mrioc: Adapter instance reference
+ * @event_reply: event data
+ *
+ * Identify whteher the event has to handled and acknowledged
+ * and either process the event in the tophalf and/or schedule a
+ * bottom half through mpi3mr_fwevt_worker.
+ *
+ * Return: Nothing
+ */
+void mpi3mr_os_handle_events(struct mpi3mr_ioc *mrioc,
+	struct _mpi3_event_notification_reply *event_reply)
+{
+	u16 evt_type, sz;
+	struct mpi3mr_fwevt *fwevt = NULL;
+	bool ack_req = 0, process_evt_bh = 0;
+
+	if (mrioc->stop_drv_processing)
+		return;
+
+	if ((event_reply->msg_flags & MPI3_EVENT_NOTIFY_MSGFLAGS_ACK_MASK)
+	    == MPI3_EVENT_NOTIFY_MSGFLAGS_ACK_REQUIRED)
+		ack_req = 1;
+
+	evt_type = event_reply->event;
+
+	switch (evt_type) {
+	case MPI3_EVENT_DEVICE_ADDED:
+	{
+		struct _mpi3_device_page0 *dev_pg0 =
+		    (struct _mpi3_device_page0 *)event_reply->event_data;
+		if (mpi3mr_create_tgtdev(mrioc, dev_pg0))
+			ioc_err(mrioc,
+			    "%s :Failed to add device in the device add event\n",
+			    __func__);
+		else
+			process_evt_bh = 1;
+		break;
+	}
+	case MPI3_EVENT_DEVICE_STATUS_CHANGE:
+	{
+		process_evt_bh = 1;
+		mpi3mr_devstatuschg_evt_th(mrioc, event_reply);
+		break;
+	}
+	case MPI3_EVENT_SAS_TOPOLOGY_CHANGE_LIST:
+	{
+		process_evt_bh = 1;
+		mpi3mr_sastopochg_evt_th(mrioc, event_reply);
+		break;
+	}
+	case MPI3_EVENT_DEVICE_INFO_CHANGED:
+	{
+		process_evt_bh = 1;
+		break;
+	}
+	case MPI3_EVENT_ENCL_DEVICE_STATUS_CHANGE:
+	case MPI3_EVENT_SAS_DISCOVERY:
+	case MPI3_EVENT_SAS_DEVICE_DISCOVERY_ERROR:
+		break;
+	default:
+		ioc_info(mrioc, "%s :event 0x%02x is not handled\n",
+		    __func__, evt_type);
+		break;
+	}
+	if (process_evt_bh || ack_req) {
+		sz = event_reply->event_data_length * 4;
+		fwevt = mpi3mr_alloc_fwevt(sz);
+		if (!fwevt) {
+			ioc_info(mrioc, "%s :failure at %s:%d/%s()!\n",
+			    __func__, __FILE__, __LINE__, __func__);
+			return;
+		}
+
+		memcpy(fwevt->event_data, event_reply->event_data, sz);
+		fwevt->mrioc = mrioc;
+		fwevt->event_id = evt_type;
+		fwevt->send_ack = ack_req;
+		fwevt->process_evt = process_evt_bh;
+		fwevt->evt_ctx = le32_to_cpu(event_reply->event_context);
+		mpi3mr_fwevt_add_to_list(mrioc, fwevt);
+	}
+}
+
 /**
  * mpi3mr_process_op_reply_desc - reply descriptor handler
  * @mrioc: Adapter instance reference
@@ -584,6 +1846,33 @@ static int mpi3mr_scan_finished(struct Scsi_Host *shost,
  */
 static void mpi3mr_slave_destroy(struct scsi_device *sdev)
 {
+	struct Scsi_Host *shost;
+	struct mpi3mr_ioc *mrioc;
+	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data;
+	struct mpi3mr_tgt_dev *tgt_dev;
+	unsigned long flags;
+	struct scsi_target *starget;
+
+	if (!sdev->hostdata)
+		return;
+
+	starget = scsi_target(sdev);
+	shost = dev_to_shost(&starget->dev);
+	mrioc = shost_priv(shost);
+	scsi_tgt_priv_data = starget->hostdata;
+
+	scsi_tgt_priv_data->num_luns--;
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	tgt_dev = __mpi3mr_get_tgtdev_by_perst_id(mrioc, starget->id);
+	if (tgt_dev && (!scsi_tgt_priv_data->num_luns))
+		tgt_dev->starget = NULL;
+	if (tgt_dev)
+		mpi3mr_tgtdev_put(tgt_dev);
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+
+	kfree(sdev->hostdata);
+	sdev->hostdata = NULL;
 }
 
 /**
@@ -596,6 +1885,34 @@ static void mpi3mr_slave_destroy(struct scsi_device *sdev)
  */
 static void mpi3mr_target_destroy(struct scsi_target *starget)
 {
+	struct Scsi_Host *shost;
+	struct mpi3mr_ioc *mrioc;
+	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data;
+	struct mpi3mr_tgt_dev *tgt_dev;
+	unsigned long flags;
+
+	if (!starget->hostdata)
+		return;
+
+	shost = dev_to_shost(&starget->dev);
+	mrioc = shost_priv(shost);
+	scsi_tgt_priv_data = starget->hostdata;
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	tgt_dev = __mpi3mr_get_tgtdev_from_tgtpriv(mrioc, scsi_tgt_priv_data);
+	if (tgt_dev && (tgt_dev->starget == starget) &&
+	    (tgt_dev->perst_id == starget->id))
+		tgt_dev->starget = NULL;
+	if (tgt_dev) {
+		scsi_tgt_priv_data->tgt_dev = NULL;
+		scsi_tgt_priv_data->perst_id = 0;
+		mpi3mr_tgtdev_put(tgt_dev);
+		mpi3mr_tgtdev_put(tgt_dev);
+	}
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+
+	kfree(starget->hostdata);
+	starget->hostdata = NULL;
 }
 
 /**
@@ -609,7 +1926,25 @@ static void mpi3mr_target_destroy(struct scsi_target *starget)
  */
 static int mpi3mr_slave_configure(struct scsi_device *sdev)
 {
+	struct scsi_target *starget;
+	struct Scsi_Host *shost;
+	struct mpi3mr_ioc *mrioc;
+	struct mpi3mr_tgt_dev *tgt_dev;
+	unsigned long flags;
 	int retval = 0;
+
+	starget = scsi_target(sdev);
+	shost = dev_to_shost(&starget->dev);
+	mrioc = shost_priv(shost);
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	tgt_dev = __mpi3mr_get_tgtdev_by_perst_id(mrioc, starget->id);
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+	if (!tgt_dev)
+		return -ENXIO;
+
+	mpi3mr_tgtdev_put(tgt_dev);
+
 	return retval;
 }
 
@@ -623,7 +1958,45 @@ static int mpi3mr_slave_configure(struct scsi_device *sdev)
  */
 static int mpi3mr_slave_alloc(struct scsi_device *sdev)
 {
+	struct Scsi_Host *shost;
+	struct mpi3mr_ioc *mrioc;
+	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data;
+	struct mpi3mr_tgt_dev *tgt_dev;
+	struct mpi3mr_sdev_priv_data *scsi_dev_priv_data;
+	unsigned long flags;
+	struct scsi_target *starget;
 	int retval = 0;
+
+	starget = scsi_target(sdev);
+	shost = dev_to_shost(&starget->dev);
+	mrioc = shost_priv(shost);
+	scsi_tgt_priv_data = starget->hostdata;
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	tgt_dev = __mpi3mr_get_tgtdev_by_perst_id(mrioc, starget->id);
+
+	if (tgt_dev) {
+		if (tgt_dev->starget == NULL)
+			tgt_dev->starget = starget;
+		mpi3mr_tgtdev_put(tgt_dev);
+		retval = 0;
+	} else {
+		spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+		return -ENXIO;
+	}
+
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+
+	scsi_dev_priv_data = kzalloc(sizeof(*scsi_dev_priv_data), GFP_KERNEL);
+	if (!scsi_dev_priv_data)
+		return -ENOMEM;
+
+	scsi_dev_priv_data->lun_id = sdev->lun;
+	scsi_dev_priv_data->tgt_priv_data = scsi_tgt_priv_data;
+	sdev->hostdata = scsi_dev_priv_data;
+
+	scsi_tgt_priv_data->num_luns++;
+
 	return retval;
 }
 
@@ -637,7 +2010,39 @@ static int mpi3mr_slave_alloc(struct scsi_device *sdev)
  */
 static int mpi3mr_target_alloc(struct scsi_target *starget)
 {
-	int retval = -ENODEV;
+	struct Scsi_Host *shost = dev_to_shost(&starget->dev);
+	struct mpi3mr_ioc *mrioc = shost_priv(shost);
+	struct mpi3mr_stgt_priv_data *scsi_tgt_priv_data;
+	struct mpi3mr_tgt_dev *tgt_dev;
+	unsigned long flags;
+	int retval = 0;
+
+	scsi_tgt_priv_data = kzalloc(sizeof(*scsi_tgt_priv_data), GFP_KERNEL);
+	if (!scsi_tgt_priv_data)
+		return -ENOMEM;
+
+	starget->hostdata = scsi_tgt_priv_data;
+	scsi_tgt_priv_data->starget = starget;
+	scsi_tgt_priv_data->dev_handle = MPI3MR_INVALID_DEV_HANDLE;
+
+	spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
+	tgt_dev = __mpi3mr_get_tgtdev_by_perst_id(mrioc, starget->id);
+	if (tgt_dev && !tgt_dev->is_hidden) {
+		starget->hostdata = scsi_tgt_priv_data;
+		scsi_tgt_priv_data->starget = starget;
+		scsi_tgt_priv_data->dev_handle = tgt_dev->dev_handle;
+		scsi_tgt_priv_data->perst_id = tgt_dev->perst_id;
+		scsi_tgt_priv_data->dev_type = tgt_dev->dev_type;
+		scsi_tgt_priv_data->tgt_dev = tgt_dev;
+		tgt_dev->starget = starget;
+		atomic_set(&scsi_tgt_priv_data->block_io, 0);
+		retval = 0;
+	} else {
+		kfree(scsi_tgt_priv_data);
+		retval = -ENXIO;
+	}
+	spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
+
 	return retval;
 }
 
@@ -832,7 +2237,7 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct mpi3mr_ioc *mrioc = NULL;
 	struct Scsi_Host *shost = NULL;
-	int retval = 0;
+	int retval = 0, i;
 
 	shost = scsi_host_alloc(&mpi3mr_driver_template,
 	    sizeof(struct mpi3mr_ioc));
@@ -853,11 +2258,21 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&mrioc->admin_req_lock);
 	spin_lock_init(&mrioc->reply_free_queue_lock);
 	spin_lock_init(&mrioc->sbq_lock);
+	spin_lock_init(&mrioc->fwevt_lock);
+	spin_lock_init(&mrioc->tgtdev_lock);
 	spin_lock_init(&mrioc->watchdog_lock);
 	spin_lock_init(&mrioc->chain_buf_lock);
 
+	INIT_LIST_HEAD(&mrioc->fwevt_list);
+	INIT_LIST_HEAD(&mrioc->tgtdev_list);
+	INIT_LIST_HEAD(&mrioc->delayed_rmhs_list);
+
 	mpi3mr_init_drv_cmd(&mrioc->init_cmds, MPI3MR_HOSTTAG_INITCMDS);
 
+	for (i = 0; i < MPI3MR_NUM_DEVRMCMD; i++)
+		mpi3mr_init_drv_cmd(&mrioc->dev_rmhs_cmds[i],
+		    MPI3MR_HOSTTAG_DEVRMCMD_MIN + i);
+
 	if (pdev->revision)
 		mrioc->enable_segqueue = true;
 
@@ -873,6 +2288,17 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->max_channel = 1;
 	shost->max_id = 0xFFFFFFFF;
 
+	snprintf(mrioc->fwevt_worker_name, sizeof(mrioc->fwevt_worker_name),
+	    "%s%d_fwevt_wrkr", mrioc->driver_name, mrioc->id);
+	mrioc->fwevt_worker_thread = alloc_ordered_workqueue(
+	    mrioc->fwevt_worker_name, WQ_MEM_RECLAIM);
+	if (!mrioc->fwevt_worker_thread) {
+		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
+		    __FILE__, __LINE__, __func__);
+		retval = -ENODEV;
+		goto out_fwevtthread_failed;
+	}
+
 	mrioc->is_driver_loading = 1;
 	if (mpi3mr_init_ioc(mrioc)) {
 		ioc_err(mrioc, "failure at %s:%d/%s()!\n",
@@ -899,6 +2325,8 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 addhost_failed:
 	mpi3mr_cleanup_ioc(mrioc);
 out_iocinit_failed:
+	destroy_workqueue(mrioc->fwevt_worker_thread);
+out_fwevtthread_failed:
 	spin_lock(&mrioc_list_lock);
 	list_del(&mrioc->list);
 	spin_unlock(&mrioc_list_lock);
@@ -920,14 +2348,30 @@ static void mpi3mr_remove(struct pci_dev *pdev)
 {
 	struct Scsi_Host *shost = pci_get_drvdata(pdev);
 	struct mpi3mr_ioc *mrioc;
+	struct workqueue_struct	*wq;
+	unsigned long flags;
+	struct mpi3mr_tgt_dev *tgtdev, *tgtdev_next;
 
 	mrioc = shost_priv(shost);
 	while (mrioc->reset_in_progress || mrioc->is_driver_loading)
 		ssleep(1);
 
 	mrioc->stop_drv_processing = 1;
+	mpi3mr_cleanup_fwevt_list(mrioc);
+	spin_lock_irqsave(&mrioc->fwevt_lock, flags);
+	wq = mrioc->fwevt_worker_thread;
+	mrioc->fwevt_worker_thread = NULL;
+	spin_unlock_irqrestore(&mrioc->fwevt_lock, flags);
+	if (wq)
+		destroy_workqueue(wq);
 	scsi_remove_host(shost);
 
+	list_for_each_entry_safe(tgtdev, tgtdev_next, &mrioc->tgtdev_list,
+	    list) {
+		mpi3mr_remove_tgtdev_from_host(mrioc, tgtdev);
+		mpi3mr_tgtdev_del_from_list(mrioc, tgtdev);
+		mpi3mr_tgtdev_put(tgtdev);
+	}
 	mpi3mr_cleanup_ioc(mrioc);
 
 	spin_lock(&mrioc_list_lock);
@@ -950,6 +2394,8 @@ static void mpi3mr_shutdown(struct pci_dev *pdev)
 {
 	struct Scsi_Host *shost = pci_get_drvdata(pdev);
 	struct mpi3mr_ioc *mrioc;
+	struct workqueue_struct	*wq;
+	unsigned long flags;
 
 	if (!shost)
 		return;
@@ -959,6 +2405,13 @@ static void mpi3mr_shutdown(struct pci_dev *pdev)
 		ssleep(1);
 
 	mrioc->stop_drv_processing = 1;
+	mpi3mr_cleanup_fwevt_list(mrioc);
+	spin_lock_irqsave(&mrioc->fwevt_lock, flags);
+	wq = mrioc->fwevt_worker_thread;
+	mrioc->fwevt_worker_thread = NULL;
+	spin_unlock_irqrestore(&mrioc->fwevt_lock, flags);
+	if (wq)
+		destroy_workqueue(wq);
 	mpi3mr_cleanup_ioc(mrioc);
 }
 
-- 
2.18.1


--0000000000007e085905c2133864
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDHA7TgNc55htm2viYDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxMjU2MDJaFw0yMjA5MTUxMTQ1MTZaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDUthc2h5YXAgRGVzYWkxKTAnBgkqhkiG9w0B
CQEWGmthc2h5YXAuZGVzYWlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAzPAzyHBqFL/1u7ttl86wZrWK3vYcqFH+GBe0laKvAGOuEkaHijHa8iH+9GA8FUv1cdWF
WY3c3BGA+omJGYc4eHLEyKowuLRWvjV3MEjGBG7NIVoIaTkH4R+6Xs1P4/9EmUA0WI881B3pTv5W
nHG54/aqGUDSRDyWVhK7TLqJQkkiYKB0kH0GkB/UfmU/pmCaV68w5J6l4vz/TG23hWJmTg1lW5mu
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIG4PDPlRdCmIFBsFAXAx7MlKk5BN
RJhruxaSPBprp5YTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxMTE5NTEzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB363Ik88FUyOv5NCLtB37uZQDafqL7+134Rnrq5bNH5+F3
856dJkpBSIhKBUHaeHEeTx0OrTO+eYMByHW2gXOc8VfgfxbRH9dSYcfh2Y8POBRVbuLtJtAPEDDe
zXlrzEt1z8OSt3doUQwuhYsVMW9MbuJjHswQMGV2CwMFq3ylYtfs/QpWJ9dwSa2hUDjvZAXzbzex
Z+UMNgjXWW4eLEfb4H73p3tf2I40RuPil1hs7oVebnd1Al88BEWfggUinssuDt+Vx/SrrYhy51vq
6IDKqFzirSswpP2wOcF7CUQhqtXRXw8mcSbecY03BSQnRbBOUNGddPuiNSClbkexnEP0
--0000000000007e085905c2133864--
