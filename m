Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1993925A40E
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Sep 2020 05:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgIBDdK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Sep 2020 23:33:10 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33247 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBDdK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Sep 2020 23:33:10 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200902033307epoutp0484648bb4a316123e55eec5bec0345527~w2gX-vveH0353303533epoutp04E
        for <linux-scsi@vger.kernel.org>; Wed,  2 Sep 2020 03:33:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200902033307epoutp0484648bb4a316123e55eec5bec0345527~w2gX-vveH0353303533epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599017587;
        bh=fQzOwnKl71y9vFlqOMQkwhC4yQbO7O5YdXFCmZaDovU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=JRT9i3iQiZGGjq5SuwiE95kQlxrSYKTCXgEbs+3MAc0cKttb4UGMC0b46IjboG0wv
         vW3su88ohei3rPLOuSf+DPdV1nsAba87CwpYorFEw5cfW93CxJyxQ4Xy8pyKmLBZzI
         5GifyZWz/LWqf1PkZF3Kd7F4/QyEIWj3oLgDpLmw=
Received: from epcpadp2 (unknown [182.195.40.12]) by epcas1p1.samsung.com
        (KnoxPortal) with ESMTP id
        20200902033306epcas1p1dcfb65011bc6803bd9475bf1deed13a1~w2gXTOSOK1688716887epcas1p1p;
        Wed,  2 Sep 2020 03:33:06 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH v11 4/4] scsi: ufs: Prepare HPB read for cached sub-region
Reply-To: daejun7.park@samsung.com
From:   Daejun Park <daejun7.park@samsung.com>
To:     Daejun Park <daejun7.park@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sang-yoon Oh <sangyoon.oh@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>,
        yongmyung lee <ymhungry.lee@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Adel Choi <adel.choi@samsung.com>,
        BoRam Shin <boram.shin@samsung.com>,
        SEUNGUK SHIN <seunguk.shin@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <231786897.01599016802080.JavaMail.epsvc@epcpadp1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1431530910.81599017586257.JavaMail.epsvc@epcpadp2>
Date:   Wed, 02 Sep 2020 12:22:27 +0900
X-CMS-MailID: 20200902032227epcms2p6cab951031ee7d2fbc33058f8b07f1a0b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20200902031713epcms2p664cebf386ba19d3d05895fec89aaf4fe
References: <231786897.01599016802080.JavaMail.epsvc@epcpadp1>
        <CGME20200902031713epcms2p664cebf386ba19d3d05895fec89aaf4fe@epcms2p6>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch changes the read I/O to the HPB read I/O.

If the logical address of the read I/O belongs to active sub-region, the
HPB driver modifies the read I/O command to HPB read. It modifies the UPIU
command of UFS instead of modifying the existing SCSI command.

In the HPB version 1.0, the maximum read I/O size that can be converted to
HPB read is 4KB.

The dirty map of the active sub-region prevents an incorrect HPB read that
has stale physical page number which is updated by previous write I/O.

Acked-by: Avri Altman <Avri.Altman@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Tested-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 drivers/scsi/ufs/ufshpb.c | 231 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 231 insertions(+)

diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 2ac4cd6e4aa4..8ad2a711dd16 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -31,6 +31,29 @@ bool ufshpb_is_allowed(struct ufs_hba *hba)
 	return !(hba->ufshpb_dev.hpb_disabled);
 }
 
+static int ufshpb_is_valid_srgn(struct ufshpb_region *rgn,
+			     struct ufshpb_subregion *srgn)
+{
+	return rgn->rgn_state != HPB_RGN_INACTIVE &&
+		srgn->srgn_state == HPB_SRGN_VALID;
+}
+
+static bool ufshpb_is_read_cmd(struct scsi_cmnd *cmd)
+{
+	return req_op(cmd->request) == REQ_OP_READ;
+}
+
+static bool ufshpb_is_write_discard_cmd(struct scsi_cmnd *cmd)
+{
+	return op_is_write(req_op(cmd->request)) ||
+	       op_is_discard(req_op(cmd->request));
+}
+
+static bool ufshpb_is_support_chunk(int transfer_len)
+{
+	return transfer_len <= HPB_MULTI_CHUNK_HIGH;
+}
+
 static bool ufshpb_is_general_lun(int lun)
 {
 	return lun < UFS_UPIU_MAX_UNIT_NUM_ID;
@@ -97,8 +120,216 @@ static void ufshpb_set_state(struct ufshpb_lu *hpb, int state)
 	atomic_set(&hpb->hpb_state, state);
 }
 
+static void ufshpb_set_ppn_dirty(struct ufshpb_lu *hpb, int rgn_idx,
+			     int srgn_idx, int srgn_offset, int cnt)
+{
+	struct ufshpb_region *rgn;
+	struct ufshpb_subregion *srgn;
+	int set_bit_len;
+	int bitmap_len = hpb->entries_per_srgn;
+
+next_srgn:
+	rgn = hpb->rgn_tbl + rgn_idx;
+	srgn = rgn->srgn_tbl + srgn_idx;
+
+	if ((srgn_offset + cnt) > bitmap_len)
+		set_bit_len = bitmap_len - srgn_offset;
+	else
+		set_bit_len = cnt;
+
+	if (rgn->rgn_state != HPB_RGN_INACTIVE &&
+	    srgn->srgn_state == HPB_SRGN_VALID)
+		bitmap_set(srgn->mctx->ppn_dirty, srgn_offset, set_bit_len);
+
+	srgn_offset = 0;
+	if (++srgn_idx == hpb->srgns_per_rgn) {
+		srgn_idx = 0;
+		rgn_idx++;
+	}
+
+	cnt -= set_bit_len;
+	if (cnt > 0)
+		goto next_srgn;
+
+	WARN_ON(cnt < 0);
+}
+
+static bool ufshpb_test_ppn_dirty(struct ufshpb_lu *hpb, int rgn_idx,
+				   int srgn_idx, int srgn_offset, int cnt)
+{
+	struct ufshpb_region *rgn;
+	struct ufshpb_subregion *srgn;
+	int bitmap_len = hpb->entries_per_srgn;
+	int bit_len;
+
+next_srgn:
+	rgn = hpb->rgn_tbl + rgn_idx;
+	srgn = rgn->srgn_tbl + srgn_idx;
+
+	if (!ufshpb_is_valid_srgn(rgn, srgn))
+		return true;
+
+	/*
+	 * If the region state is active, mctx must be allocated.
+	 * In this case, check whether the region is evicted or
+	 * mctx allcation fail.
+	 */
+	WARN_ON(!srgn->mctx);
+
+	if ((srgn_offset + cnt) > bitmap_len)
+		bit_len = bitmap_len - srgn_offset;
+	else
+		bit_len = cnt;
+
+	if (find_next_bit(srgn->mctx->ppn_dirty,
+			  bit_len, srgn_offset) >= srgn_offset)
+		return true;
+
+	srgn_offset = 0;
+	if (++srgn_idx == hpb->srgns_per_rgn) {
+		srgn_idx = 0;
+		rgn_idx++;
+	}
+
+	cnt -= bit_len;
+	if (cnt > 0)
+		goto next_srgn;
+
+	return false;
+}
+
+static u64 ufshpb_get_ppn(struct ufshpb_lu *hpb,
+			  struct ufshpb_map_ctx *mctx, int pos, int *error)
+{
+	u64 *ppn_table;
+	struct page *page;
+	int index, offset;
+
+	index = pos / (PAGE_SIZE / HPB_ENTRY_SIZE);
+	offset = pos % (PAGE_SIZE / HPB_ENTRY_SIZE);
+
+	page = mctx->m_page[index];
+	if (unlikely(!page)) {
+		*error = -ENOMEM;
+		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
+			"error. cannot find page in mctx\n");
+		return 0;
+	}
+
+	ppn_table = page_address(page);
+	if (unlikely(!ppn_table)) {
+		*error = -ENOMEM;
+		dev_err(&hpb->sdev_ufs_lu->sdev_dev,
+			"error. cannot get ppn_table\n");
+		return 0;
+	}
+
+	return ppn_table[offset];
+}
+
+static void
+ufshpb_get_pos_from_lpn(struct ufshpb_lu *hpb, unsigned long lpn, int *rgn_idx,
+			int *srgn_idx, int *offset)
+{
+	int rgn_offset;
+
+	*rgn_idx = lpn >> hpb->entries_per_rgn_shift;
+	rgn_offset = lpn & hpb->entries_per_rgn_mask;
+	*srgn_idx = rgn_offset >> hpb->entries_per_srgn_shift;
+	*offset = rgn_offset & hpb->entries_per_srgn_mask;
+}
+
+static void
+ufshpb_set_hpb_read_to_upiu(struct ufshpb_lu *hpb, struct ufshcd_lrb *lrbp,
+				  u32 lpn, u64 ppn,  unsigned int transfer_len)
+{
+	unsigned char *cdb = lrbp->ucd_req_ptr->sc.cdb;
+
+	cdb[0] = UFSHPB_READ;
+
+	put_unaligned_be64(ppn, &cdb[6]);
+	cdb[14] = transfer_len;
+}
+
+/*
+ * This function will set up HPB read command using host-side L2P map data.
+ * In HPB v1.0, maximum size of HPB read command is 4KB.
+ */
 void ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 {
+	struct ufshpb_lu *hpb;
+	struct ufshpb_region *rgn;
+	struct ufshpb_subregion *srgn;
+	struct scsi_cmnd *cmd = lrbp->cmd;
+	u32 lpn;
+	u64 ppn;
+	unsigned long flags;
+	int transfer_len, rgn_idx, srgn_idx, srgn_offset;
+	int err = 0;
+
+	hpb = ufshpb_get_hpb_data(cmd);
+	if (!hpb)
+		return;
+
+	if (ufshpb_get_state(hpb) != HPB_PRESENT) {
+		dev_notice(&hpb->sdev_ufs_lu->sdev_dev,
+			   "%s: ufshpb state is not PRESENT", __func__);
+		return;
+	}
+
+	WARN_ON(hpb->lun != cmd->device->lun);
+	if (!ufshpb_is_write_discard_cmd(cmd) &&
+	    !ufshpb_is_read_cmd(cmd))
+		return;
+
+	transfer_len = sectors_to_logical(cmd->device, blk_rq_sectors(cmd->request));
+	if (unlikely(!transfer_len))
+		return;
+
+	lpn = sectors_to_logical(cmd->device, blk_rq_pos(cmd->request));
+	ufshpb_get_pos_from_lpn(hpb, lpn, &rgn_idx, &srgn_idx, &srgn_offset);
+	rgn = hpb->rgn_tbl + rgn_idx;
+	srgn = rgn->srgn_tbl + srgn_idx;
+
+	/* If command type is WRITE or DISCARD, set bitmap as drity */
+	if (ufshpb_is_write_discard_cmd(cmd)) {
+		spin_lock_irqsave(&hpb->hpb_state_lock, flags);
+		ufshpb_set_ppn_dirty(hpb, rgn_idx, srgn_idx, srgn_offset,
+				 transfer_len);
+		spin_unlock_irqrestore(&hpb->hpb_state_lock, flags);
+		return;
+	}
+
+	WARN_ON(!ufshpb_is_read_cmd(cmd));
+
+	if (!ufshpb_is_support_chunk(transfer_len))
+		return;
+
+	spin_lock_irqsave(&hpb->hpb_state_lock, flags);
+	if (ufshpb_test_ppn_dirty(hpb, rgn_idx, srgn_idx, srgn_offset,
+				   transfer_len)) {
+		atomic_inc(&hpb->stats.miss_cnt);
+		spin_unlock_irqrestore(&hpb->hpb_state_lock, flags);
+		return;
+	}
+
+	ppn = ufshpb_get_ppn(hpb, srgn->mctx, srgn_offset, &err);
+	spin_unlock_irqrestore(&hpb->hpb_state_lock, flags);
+	if (unlikely(err)) {
+		/*
+		 * In this case, the region state is active,
+		 * but the ppn table is not allocated.
+		 * Make sure that ppn table must be allocated on
+		 * active state.
+		 */
+		WARN_ON(true);
+		dev_err(hba->dev, "ufshpb_get_ppn failed. err %d\n", err);
+		return;
+	}
+
+	ufshpb_set_hpb_read_to_upiu(hpb, lrbp, lpn, ppn, transfer_len);
+
+	atomic_inc(&hpb->stats.hit_cnt);
 }
 
 static struct ufshpb_req *ufshpb_get_map_req(struct ufshpb_lu *hpb,
-- 
2.17.1


