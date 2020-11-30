Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15C92C8C54
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Nov 2020 19:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgK3SMp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Nov 2020 13:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgK3SMo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 30 Nov 2020 13:12:44 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA07C0613D2;
        Mon, 30 Nov 2020 10:11:58 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s13so8200688ejr.1;
        Mon, 30 Nov 2020 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCGFRNxkqVOdH2oPpvMvZWWLTLogZHhrB4I80nWfwYE=;
        b=ATy8L4S4MPS3cgLSmif9EybGT2t08UZ5ZwIwM2Msge4epnSxG9nE+3H15+qCF1ML7l
         l1/PWFqg1wFune8lHUmorQ4nCcltm+jmzl8oOt0fpNj/JiEKM41u1zxKL/Kr0qQD/oaG
         NfKbxkIsYEhoiwbEYVfMCU9tFLJWHfd9c5S9YYX4M7vnmJrC8e7Qu0c/70q3G20ID58m
         522dFpukMzXRWyiCZmUPjqarYWWdL7xohI9HbHbkYhfdvlO067MJETwHdoNUFPSM5wg0
         O1C13HFT5unglHP0QZPqu7en1DLi8yKbmNaOJ2m4tKm6LqVRPHeMnYheEELTVnzzo2DZ
         0RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCGFRNxkqVOdH2oPpvMvZWWLTLogZHhrB4I80nWfwYE=;
        b=kKTB5cUVidZzuShIB0/YGb5zrx2mLDwnOBJJqH6vEkErpQrwD7hfmKi0NbQ12J5zqH
         FdJl3iIMy1jmyaHdmUgaKaxN5AVr5i9393TBtPpCHoBfIiotSO0Xguc/y7e4Ia7TYNNd
         Rv9zV0GpsMqJEZ/t9TnJ6svNDbQIsCoelZXwdcl2IgOztiWIlLbr8Dq4EmQO+VYPWSX5
         K6t1s8eANkSL/Z0eSlgmVGeeWWyADEpfa3MsTacOWpeN1ZE3X22wh0jTqJ6ryOfXaDjs
         3YFMX3B9FBq8vYgjzUO4XF5c1IKSCTvwvFq1MloREcuhvIVmCk1Y379U2iVWftRjmkWu
         zeaw==
X-Gm-Message-State: AOAM532qoeK3t/7Z016fjmTALElmaZ3w1BtNkxd4UDuzn6uExjIgaVcX
        ssmtMxgSPknVw0jJNOLdbC0=
X-Google-Smtp-Source: ABdhPJzR3KwLg/bYDQzWMpqfTHanjQOIH8HC9BKo0hT12g4qm3ojmpPdNazEUBnUbKqa/YGog3URCQ==
X-Received: by 2002:a17:906:33c4:: with SMTP id w4mr21273300eja.380.1606759916999;
        Mon, 30 Nov 2020 10:11:56 -0800 (PST)
Received: from localhost.localdomain (ip5f5bfce9.dynamic.kabel-deutschland.de. [95.91.252.233])
        by smtp.gmail.com with ESMTPSA id d14sm2702899edn.31.2020.11.30.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 10:11:55 -0800 (PST)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Three changes for UFS WriteBooster
Date:   Mon, 30 Nov 2020 19:11:40 +0100
Message-Id: <20201130181143.5739-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>


Bean Huo (3):
  scsi: ufs: Add "wb_on" sysfs node to control WB on/off
  scsi: ufs: Keep device power on only
    fWriteBoosterBufferFlushDuringHibernate == 1
  scsi: ufs: Changes comment in the function ufshcd_wb_probe()

 drivers/scsi/ufs/ufs-sysfs.c | 33 +++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs.h       |  2 ++
 drivers/scsi/ufs/ufshcd.c    | 21 ++++++++++++++-------
 drivers/scsi/ufs/ufshcd.h    |  2 ++
 4 files changed, 51 insertions(+), 7 deletions(-)

-- 
2.17.1

