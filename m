Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222C8E5D9B
	for <lists+linux-scsi@lfdr.de>; Sat, 26 Oct 2019 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfJZON1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 26 Oct 2019 10:13:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:4865 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJZON0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 26 Oct 2019 10:13:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2019 07:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,232,1569308400"; 
   d="scan'208";a="400387356"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 26 Oct 2019 07:13:24 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1iOMom-0000iQ-Ah; Sat, 26 Oct 2019 22:13:24 +0800
Date:   Sat, 26 Oct 2019 22:13:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     James Smart <jsmart2021@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: [RFC PATCH] elx: efct: efct_libefc_templ can be static
Message-ID: <20191026141304.6bs2qp6hwhxjorw6@4978f4969bb8>
References: <20191023215557.12581-33-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023215557.12581-33-jsmart2021@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Fixes: 24d4401b1dd0 ("elx: efct: Tie into kernel Kconfig and build process")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 efct_driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index 4928e5753d88c..b00fc00a6eb02 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -46,7 +46,7 @@ struct efct_fw_write_result {
 	u32 change_status;
 };
 
-struct libefc_function_template efct_libefc_templ = {
+static struct libefc_function_template efct_libefc_templ = {
 	.hw_domain_alloc = efct_hw_domain_alloc,
 	.hw_domain_attach = efct_hw_domain_attach,
 	.hw_domain_free = efct_hw_domain_free,
