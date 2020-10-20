Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7D28D6AC
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Oct 2020 00:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgJMWpo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Oct 2020 18:45:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48204 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729463AbgJMWpf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Oct 2020 18:45:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMYZUR143659;
        Tue, 13 Oct 2020 22:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ArcMjQJ2s3MSpWrq6+n/RKwMjg3fQXUIA+bfV4ABt88=;
 b=DCrESlm8LxH93mrqtrBGTmptxeRuZ3AP0ZPQVBfF7J4wWWXvLCQY5PO1M0ZQhL1W4mrB
 1SmjeLBHBM7d1DOH6gJ4GegfPKjey8g+XaVwGmYjOt0KTfY8k5LdYBiRnip5oA/dhQX8
 30gyRpwJ8oQ+mU61DIzydNgWlUTZ4qqK6EZofvMd54A/D9gcIer+aPKfpD//LuIMw516
 bklJ7UqLaWk25s4q3jGECNtIeSHgF/M++LlOCsFARkrPlAULtuhNXR9YP8TaiDtgcAZv
 SrLmSgoUBlEBYHSylE/Hdf5VnCn9+BC4VGrPJZR9hUfjDUUrpygnG3uBMkKJbOt+WU5v CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 343pajucw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 22:45:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMZW2w162477;
        Tue, 13 Oct 2020 22:43:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 344by2v0g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 22:43:26 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DMhPRf009987;
        Tue, 13 Oct 2020 22:43:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 15:43:24 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     njavali@marvell.com, "trix@redhat.com" <trix@redhat.com>,
        natechancellor@gmail.com, jejb@linux.ibm.com,
        ndesaulniers@google.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: qla2xxx: initialize value
Date:   Tue, 13 Oct 2020 18:43:00 -0400
Message-Id: <160262862432.3018.2457748538625562502.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005144544.25335-1-trix@redhat.com>
References: <20201005144544.25335-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=771 spamscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=788 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130158
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 5 Oct 2020 07:45:44 -0700, trix@redhat.com wrote:

> clang static analysis reports this problem:
> 
> qla_nx2.c:694:3: warning: 6th function call argument is
>   an uninitialized value
>         ql_log(ql_log_fatal, vha, 0xb090,
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: qla2xxx: Initialize variable in qla8044_poll_reg()
      https://git.kernel.org/mkp/scsi/c/21a6cd48bb48

-- 
Martin K. Petersen	Oracle Linux Engineering
