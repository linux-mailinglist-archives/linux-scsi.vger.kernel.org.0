Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914E5166FE
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 17:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEGPjL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 11:39:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:36104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726197AbfEGPjL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 7 May 2019 11:39:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2B821AC8A
        for <linux-scsi@vger.kernel.org>; Tue,  7 May 2019 15:39:09 +0000 (UTC)
To:     linux-scsi@vger.kernel.org
From:   Enzo Matsumiya <ematsumiya@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=ematsumiya@suse.de; keydata=
 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
Subject: [PATCH] qla2xxx: remove double assignment in qla2x00_update_fcport
Message-ID: <e5419ee1-0ae8-2d55-666e-741efece90e6@suse.de>
Date:   Tue, 7 May 2019 12:39:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove double assignment in qla2x00_update_fcport().

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 drivers/scsi/qla2xxx/qla_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c
b/drivers/scsi/qla2xxx/qla_init.c
index 0c700b140ce7..18078e215466 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5237,7 +5237,6 @@ qla2x00_update_fcport(scsi_qla_host_t *vha,
fc_port_t *fcport)
        fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
        fcport->deleted = 0;
        fcport->logout_on_delete = 1;
-       fcport->login_retry = vha->hw->login_retry_count;
        fcport->n2n_chip_reset = fcport->n2n_link_reset_cnt = 0;

        switch (vha->hw->current_topology) {
--
2.12.3
