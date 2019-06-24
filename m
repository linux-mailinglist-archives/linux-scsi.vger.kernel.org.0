Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8288A50ED9
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 16:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfFXOnK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 10:43:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45189 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfFXOnJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 10:43:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id r1so7621033pfq.12
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4jhJAr3iF6SEc9WDpw1e1Kiv6Ep8RG3j7vryK0p8tKE=;
        b=ZUpiZ0L4+TNo5UZHtTZ4z68xaxyzOY6E010VIy6OVj5B1CTpF/xl5p4CJ5rwJdkLYD
         PIAOI96l5SCPBvJRGMy+HT8CPrfmXOY2rPowVo+l75cK6mgvcTT+y8I3HVJL7KUSfW3o
         j9eGQuoEnM9R4x74ns8zmOFQQzFWcGOCz5ixI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4jhJAr3iF6SEc9WDpw1e1Kiv6Ep8RG3j7vryK0p8tKE=;
        b=EeMU+98bioSnshIuaUiZL0hzer/G2WdvvGBKi72uWDl39PcSl8x+dkdWmJj6gWxmor
         V2kaU9ZyGWr0CIm7YQMipKdZZJ6uOhp2K2RfNHWBsGMsPLYJoixMhmBzXPgN1iBSmPeN
         UplGUx3j+ZNsF5fhSE/c/uSvwKApYrwvr3JgO/3vcRDeJ22brQimp+3WuPkw/PDZ2gI8
         MEBmMlbFixZ8OnlvZcQ0BGvD9gw0/FiY7KXvwhH5vfwBsRR2PzAGGKD7LXyhwMou0VRf
         FP7t/xbMO0piGBeOWZeAZVffiARZfj/C26X027UVmIxrq42Joe07Pmzs/iICQyZv3LHy
         sB6A==
X-Gm-Message-State: APjAAAWS1Afe+R66FA3tXVUMGkNLMky8qMhjr+Zg5sO6I6JFl2oyYD5p
        Irj6hCZXSVwSfyReN0a23oUfqA==
X-Google-Smtp-Source: APXvYqz6Btbnt4Rhym5lT1HpPVGmIihp2uanBo/6EnaF/vBqU5AN1uKg3sl7Y42ll9YstIr0oY8mlA==
X-Received: by 2002:a17:90a:d587:: with SMTP id v7mr25942519pju.28.1561387389162;
        Mon, 24 Jun 2019 07:43:09 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k197sm12991799pgc.22.2019.06.24.07.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:43:08 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, suganath-prabu.subramani@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 0/4] mpt3sas: bug fix patches
Date:   Mon, 24 Jun 2019 10:42:52 -0400
Message-Id: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch set contains some mpt3sas driver's bug fix patches.

Sreekanth Reddy (4):
  mpt3sas: Remove CPU arch check to determine perf_mode
  mpt3sas: Fix look configured PCIe link speed not cap
  mpt3sas: Fix determine smp affinity on per HBA basis
  mpt3sas: Fix msix load balance on and off settings

 drivers/scsi/mpt3sas/mpt3sas_base.c | 64 +++++++++++++++++--------------------
 drivers/scsi/mpt3sas/mpt3sas_base.h |  1 +
 2 files changed, 31 insertions(+), 34 deletions(-)

-- 
1.8.3.1

