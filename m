Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5084EEA6F
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Apr 2022 11:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbiDAJbV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Fri, 1 Apr 2022 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344586AbiDAJbS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Apr 2022 05:31:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C241F9FE6
        for <linux-scsi@vger.kernel.org>; Fri,  1 Apr 2022 02:29:28 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KVFH65pvnzdZVd;
        Fri,  1 Apr 2022 17:29:06 +0800 (CST)
Received: from dggpeml100017.china.huawei.com (7.185.36.161) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:29:27 +0800
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggpeml100017.china.huawei.com (7.185.36.161) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 17:29:26 +0800
Received: from dggpeml500019.china.huawei.com ([7.185.36.137]) by
 dggpeml500019.china.huawei.com ([7.185.36.137]) with mapi id 15.01.2308.021;
 Fri, 1 Apr 2022 17:29:26 +0800
From:   "wubo (T)" <wubo40@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        "lduncan@suse.com" <lduncan@suse.com>,
        "cleech@redhat.com" <cleech@redhat.com>,
        "njavali@marvell.com" <njavali@marvell.com>,
        "mrangankar@marvell.com" <mrangankar@marvell.com>,
        "GR-QLogic-Storage-Upstream@marvell.com" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
Subject: Re: [PATCH V3 03/15] scsi: iscsi: Merge suspend fields
Thread-Topic: [PATCH V3 03/15] scsi: iscsi: Merge suspend fields
Thread-Index: AQHYQ5egJaW/2wItYEeRSlAFUmdOeqzazloQ
Date:   Fri, 1 Apr 2022 09:29:26 +0000
Message-ID: <cdaf89a3d2fa41ce9d362165df45f917@huawei.com>
References: <20220329180326.5586-1-michael.christie@oracle.com>
 <20220329180326.5586-4-michael.christie@oracle.com>
In-Reply-To: <20220329180326.5586-4-michael.christie@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.189]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

> 
> Move the tx and rx suspend fields into one flags field.
> 
> Reviewed-by: Lee Duncan <lduncan@suse.com>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  drivers/scsi/bnx2i/bnx2i_hwi.c   |  2 +-
>  drivers/scsi/bnx2i/bnx2i_iscsi.c |  2 +-
>  drivers/scsi/cxgbi/libcxgbi.c    |  6 +++---
>  drivers/scsi/libiscsi.c          | 20 ++++++++++----------
>  drivers/scsi/libiscsi_tcp.c      |  2 +-
>  include/scsi/libiscsi.h          |  9 +++++----
>  6 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c index
> 5521469ce678..e16327a4b4c9 100644
> --- a/drivers/scsi/bnx2i/bnx2i_hwi.c
> +++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
> @@ -1977,7 +1977,7 @@ static int bnx2i_process_new_cqes(struct bnx2i_conn
> *bnx2i_conn)
>  		if (nopin->cq_req_sn != qp->cqe_exp_seq_sn)
>  			break;
> 
> -		if (unlikely(test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_rx))) {
> +		if (unlikely(test_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags)))
> {
>  			if (nopin->op_code == ISCSI_OP_NOOP_IN &&
>  			    nopin->itt == (u16) RESERVED_ITT) {
>  				printk(KERN_ALERT "bnx2i: Unsolicited "
> diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
> index fe86fd61a995..15fbd09baa94 100644
> --- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
> +++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
> @@ -1721,7 +1721,7 @@ static int bnx2i_tear_down_conn(struct bnx2i_hba
> *hba,
>  			struct iscsi_conn *conn = ep->conn->cls_conn->dd_data;
> 
>  			/* Must suspend all rx queue activity for this ep */
> -			set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_rx);
> +			set_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags);
>  		}
>  		/* CONN_DISCONNECT timeout may or may not be an issue depending
>  		 * on what transcribed in TCP layer, different targets behave diff --git
> a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c index
> 8c7d4dda4cf2..4365d52c6430 100644
> --- a/drivers/scsi/cxgbi/libcxgbi.c
> +++ b/drivers/scsi/cxgbi/libcxgbi.c
> @@ -1634,11 +1634,11 @@ void cxgbi_conn_pdu_ready(struct cxgbi_sock *csk)
>  	log_debug(1 << CXGBI_DBG_PDU_RX,
>  		"csk 0x%p, conn 0x%p.\n", csk, conn);
> 
> -	if (unlikely(!conn || conn->suspend_rx)) {
> +	if (unlikely(!conn || test_bit(ISCSI_CONN_FLAG_SUSPEND_RX,
> +&conn->flags))) {
>  		log_debug(1 << CXGBI_DBG_PDU_RX,
> -			"csk 0x%p, conn 0x%p, id %d, suspend_rx %lu!\n",
> +			"csk 0x%p, conn 0x%p, id %d, conn flags 0x%lx!\n",
>  			csk, conn, conn ? conn->id : 0xFF,
> -			conn ? conn->suspend_rx : 0xFF);
> +			conn ? conn->flags : 0xFF);
>  		return;
>  	}
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c index
> d09926e6c8a8..5e7bd5a3b430 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -1392,8 +1392,8 @@ static bool iscsi_set_conn_failed(struct iscsi_conn
> *conn)
>  	if (conn->stop_stage == 0)
>  		session->state = ISCSI_STATE_FAILED;
> 
> -	set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
> -	set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_rx);
> +	set_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
> +	set_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags);
>  	return true;
>  }
> 
> @@ -1454,7 +1454,7 @@ static int iscsi_xmit_task(struct iscsi_conn *conn, struct
> iscsi_task *task,
>  	 * Do this after dropping the extra ref because if this was a requeue
>  	 * it's removed from that list and cleanup_queued_task would miss it.
>  	 */
> -	if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx)) {
> +	if (test_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags)) {
>  		/*
>  		 * Save the task and ref in case we weren't cleaning up this
>  		 * task and get woken up again.
> @@ -1532,7 +1532,7 @@ static int iscsi_data_xmit(struct iscsi_conn *conn)
>  	int rc = 0;
> 
>  	spin_lock_bh(&conn->session->frwd_lock);
> -	if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx)) {
> +	if (test_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags)) {
>  		ISCSI_DBG_SESSION(conn->session, "Tx suspended!\n");
>  		spin_unlock_bh(&conn->session->frwd_lock);
>  		return -ENODATA;
> @@ -1746,7 +1746,7 @@ int iscsi_queuecommand(struct Scsi_Host *host, struct
> scsi_cmnd *sc)
>  		goto fault;
>  	}
> 
> -	if (test_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx)) {
> +	if (test_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags)) {
>  		reason = FAILURE_SESSION_IN_RECOVERY;
>  		sc->result = DID_REQUEUE << 16;
>  		goto fault;
> @@ -1935,7 +1935,7 @@ static void fail_scsi_tasks(struct iscsi_conn *conn, u64
> lun, int error)  void iscsi_suspend_queue(struct iscsi_conn *conn)  {
>  	spin_lock_bh(&conn->session->frwd_lock);
> -	set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
> +	set_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
>  	spin_unlock_bh(&conn->session->frwd_lock);
>  }
>  EXPORT_SYMBOL_GPL(iscsi_suspend_queue);
> @@ -1953,7 +1953,7 @@ void iscsi_suspend_tx(struct iscsi_conn *conn)
>  	struct Scsi_Host *shost = conn->session->host;
>  	struct iscsi_host *ihost = shost_priv(shost);
> 
> -	set_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
> +	set_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
>  	if (ihost->workq)
>  		flush_workqueue(ihost->workq);
>  }
> @@ -1961,7 +1961,7 @@ EXPORT_SYMBOL_GPL(iscsi_suspend_tx);
> 
>  static void iscsi_start_tx(struct iscsi_conn *conn)  {
> -	clear_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
> +	clear_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
>  	iscsi_conn_queue_work(conn);
>  }
> 
> @@ -3330,8 +3330,8 @@ int iscsi_conn_bind(struct iscsi_cls_session
> *cls_session,
>  	/*
>  	 * Unblock xmitworker(), Login Phase will pass through.
>  	 */
> -	clear_bit(ISCSI_SUSPEND_BIT, &conn->suspend_rx);
> -	clear_bit(ISCSI_SUSPEND_BIT, &conn->suspend_tx);
> +	clear_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags);
> +	clear_bit(ISCSI_CONN_FLAG_SUSPEND_TX, &conn->flags);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iscsi_conn_bind);
> diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c index
> 2e9ffe3d1a55..883005757ddb 100644
> --- a/drivers/scsi/libiscsi_tcp.c
> +++ b/drivers/scsi/libiscsi_tcp.c
> @@ -927,7 +927,7 @@ int iscsi_tcp_recv_skb(struct iscsi_conn *conn, struct
> sk_buff *skb,
>  	 */
>  	conn->last_recv = jiffies;
> 
> -	if (unlikely(conn->suspend_rx)) {
> +	if (unlikely(test_bit(ISCSI_CONN_FLAG_SUSPEND_RX, &conn->flags))) {
>  		ISCSI_DBG_TCP(conn, "Rx suspended!\n");
>  		*status = ISCSI_TCP_SUSPENDED;
>  		return 0;
> diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h index
> e76c94697c1b..84086c240228 100644
> --- a/include/scsi/libiscsi.h
> +++ b/include/scsi/libiscsi.h
> @@ -53,8 +53,10 @@ enum {
> 
>  #define ISID_SIZE			6
> 
> -/* Connection suspend "bit" */
> -#define ISCSI_SUSPEND_BIT		1
> +/* Connection flags */
> +#define ISCSI_CONN_FLAG_SUSPEND_TX	BIT(0)
> +#define ISCSI_CONN_FLAG_SUSPEND_RX	BIT(1)
> +
> 
>  #define ISCSI_ITT_MASK			0x1fff
>  #define ISCSI_TOTAL_CMDS_MAX		4096
> @@ -211,8 +213,7 @@ struct iscsi_conn {
>  	struct list_head	cmdqueue;	/* data-path cmd queue */
>  	struct list_head	requeue;	/* tasks needing another run */
>  	struct work_struct	xmitwork;	/* per-conn. xmit workqueue */
> -	unsigned long		suspend_tx;	/* suspend Tx */
> -	unsigned long		suspend_rx;	/* suspend Rx */
> +	unsigned long		flags;		/* ISCSI_CONN_FLAGs */
> 
>  	/* negotiated params */
>  	unsigned		max_recv_dlength; /* initiator_max_recv_dsl*/
> --
> 2.25.1

Reviewed-by: Wu Bo <wubo40@huawei.com>
