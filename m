Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D106F41B67B
	for <lists+linux-scsi@lfdr.de>; Tue, 28 Sep 2021 20:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbhI1Sq2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 28 Sep 2021 14:46:28 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18581 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242189AbhI1Sq1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 28 Sep 2021 14:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632854687; x=1664390687;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=SelvhBwj7Th1xhv+/kc3HZiyn7eQgtcqtkjcBLkZqdzoSd615Ykdc6bp
   syrPAU0iJL8beXl/ZuGGqlYGGC75NsGxmRaMJ6JqMHQZ+hk2f9lrjVBun
   iCuBUGkK8501GSBtfmbbo9ySYC1zZIMS3011sgBv+D68gftWwhDLeQ+p0
   xtmsBpmsg/Ie50prwppY+SEuVLOFonDjYo+MIoOQqF1WAWzxUocVHPWGV
   +QqnaQ5ezgC6EjXqTAEfHLfhI1ucQ7gT3Eh4IuJ1vjlXlS2voy0c1fI1t
   EVIDc87BHU+YfxxqyyoCL91+9GScpDyynZrab77/qaI0q8eYMzF/85eeN
   w==;
IronPort-SDR: Ndg5lp1PD2W98mS/OKL/ZjbxenJpgeVe+AkW+Yu8N0nRLya9gkI4sDoMzQ6sAu9lBwNscuvKPl
 ufVQ4s1d0yikTYBX1tXaKOSGy81IVhZ6nnwMjRNfIhI7jyu2aks9bE6hDsuVuCMkLGzS6QDFKH
 J/+u/veLjMaxwHKArUP6aueMN8ziQ/1B4Q114DS++owxFFq23MBmvlX4/UpU9R9VBVPaGlV3qF
 bxBthvTx1zhcQcdZFmREd9crTC5HuUbS4w4S6PuUnr9yLeT3YIHfqffO2vGU5AGaHB2OtT7yaf
 Qsq/IjGFGG5SQBsVP+zaqIAn
X-IronPort-AV: E=Sophos;i="5.85,330,1624345200"; 
   d="scan'208";a="130992406"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Sep 2021 11:44:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 28 Sep 2021 11:44:46 -0700
Received: from brunhilda.pdev.net (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 28 Sep 2021 11:44:46 -0700
Subject: [PATCH 02/11] smartpqi: add controller handshake during kdump
From:   Don Brace <don.brace@microchip.com>
To:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <gerry.morong@microchip.com>, <mahesh.rajashekhara@microchip.com>,
        <mike.mcgowen@microchip.com>, <murthy.bhat@microchip.com>,
        <hch@infradead.org>, <jejb@linux.vnet.ibm.com>,
        <joseph.szczypek@hpe.com>, <POSWALD@suse.com>
CC:     <linux-scsi@vger.kernel.org>
Date:   Tue, 28 Sep 2021 13:44:46 -0500
Message-ID: <163285468602.194893.7720044279784842621.stgit@brunhilda.pdev.net>
In-Reply-To: <163285461769.194893.178408874562704189.stgit@brunhilda.pdev.net>
References: <163285461769.194893.178408874562704189.stgit@brunhilda.pdev.net>
User-Agent: StGit/1.1+40.g1b20.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


