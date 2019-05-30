Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5532EAAC
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 04:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE3C2B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 22:28:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49104 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfE3C2B (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 22:28:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2J18r011927;
        Thu, 30 May 2019 02:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=IlsDG4hHPmeKifqFB08mJ/RL76to7tRBSNqZcVgHeUo=;
 b=qVIqf5GLFIiHBZMHkCb4Xe0RUCu8zUUfW4QVflty7sDFKhKL0D/MXHxnhkKj9MHXDUCp
 Pfg87yb6zuu9OTDXv3cwdLPqC+X/vK0z0PbMuYtjaqoLiF0o9bCx0zu7GPnQFrdBsXxg
 fwRAc76PJ9IW3WsQ6h/zqtxC3JXOZsyafpoBQURCJaRzRpMCxHZsZ7wGaGLsDPiVUJWq
 RGHXDtggJlIPk7BJjLBnIdS6TqCmNomreFHNT0eNrhYRql0NQUhI3IGyb1jNh+uPtXSE
 WT7K/WuQXyEi32CEYGPlYk5Fbl3aainS7qV7L8kokUgsDndZsgjwGh9vPFCUhJMlk1mn ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 2spu7dnkvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:27:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2RrY4016793;
        Thu, 30 May 2019 02:27:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2srbdxqw9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:27:53 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4U2RlS1010612;
        Thu, 30 May 2019 02:27:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:27:46 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] qla2xxx: remove double assignment in qla2x00_update_fcport
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <e5419ee1-0ae8-2d55-666e-741efece90e6@suse.de>
Date:   Wed, 29 May 2019 22:27:44 -0400
In-Reply-To: <e5419ee1-0ae8-2d55-666e-741efece90e6@suse.de> (Enzo Matsumiya's
        message of "Tue, 7 May 2019 12:39:05 -0300")
Message-ID: <yq11s0gy8v3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300016
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu?

> Remove double assignment in qla2x00_update_fcport().
>
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> ---
>  drivers/scsi/qla2xxx/qla_init.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/scsi/qla2xxx/qla_init.c
> b/drivers/scsi/qla2xxx/qla_init.c
> index 0c700b140ce7..18078e215466 100644
> --- a/drivers/scsi/qla2xxx/qla_init.c
> +++ b/drivers/scsi/qla2xxx/qla_init.c
> @@ -5237,7 +5237,6 @@ qla2x00_update_fcport(scsi_qla_host_t *vha,
> fc_port_t *fcport)
>         fcport->flags &= ~(FCF_LOGIN_NEEDED | FCF_ASYNC_SENT);
>         fcport->deleted = 0;
>         fcport->logout_on_delete = 1;
> -       fcport->login_retry = vha->hw->login_retry_count;
>         fcport->n2n_chip_reset = fcport->n2n_link_reset_cnt = 0;
>
>         switch (vha->hw->current_topology) {
> --
> 2.12.3
>
>

-- 
Martin K. Petersen	Oracle Linux Engineering
