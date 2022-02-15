Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397824B6180
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Feb 2022 04:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiBODTr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 14 Feb 2022 22:19:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiBODTq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 14 Feb 2022 22:19:46 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7B0205C9
        for <linux-scsi@vger.kernel.org>; Mon, 14 Feb 2022 19:19:37 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21F2WvHe022038;
        Tue, 15 Feb 2022 03:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2021-07-09;
 bh=S80xJOvaG/eXKpbZuphP2ygh3n8U89Yjggd2VOPpbh4=;
 b=fQrVDJcNwf0CfOofvFYXoPLQW6QNVoG+hyUCOGPzrb1sKWeFqc3ZpnT650K17mSHhrA2
 UoEJGlcu6/g+7yqle96tJfNnhW1kDHGG5AbBUoSM+6IcxtgEq2Q+LLBmcI+Nr8W6mUc0
 J58nXr6egXXfqZ9/AafUA7jCTljbLBWIIuAwoVkhwvBtHf1O+DVuFKCrRWhQnRbsdjoz
 z7RGlTZNWfPUdj9A5j6SvldpsKPVgpIRw8FJfoMJb+alOJsHIQQvUgy5M5molkcCVpYj
 MS1z3xovTGIdNlA0lTxdczQJDhE9uXtPngM3ljkH+7Tt4SnrbHxf8PydF3eGH8s+FxbD Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63ad6bqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 03:19:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21F3Gmub057561;
        Tue, 15 Feb 2022 03:19:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3e620wpgqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 03:19:23 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 21F3JMP2064243;
        Tue, 15 Feb 2022 03:19:22 GMT
Received: from ca-mkp.mkp.ca.oracle.com (ca-mkp.ca.oracle.com [10.156.108.201])
        by userp3030.oracle.com with ESMTP id 3e620wpgqq-1;
        Tue, 15 Feb 2022 03:19:22 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     chenxiang <chenxiang66@hisilicon.com>, jejb@linux.vnet.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxarm@huawei.com,
        john.garry@huawei.com
Subject: Re: [PATCH 0/4] Some small cleanups for scsi/libsas
Date:   Mon, 14 Feb 2022 22:19:13 -0500
Message-Id: <164489513315.15031.3016260424008065999.b4-ty@oracle.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1644561778-183074-1-git-send-email-chenxiang66@hisilicon.com>
References: <1644561778-183074-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: upJ3djYcZxgHdoQisBColz9-kmPEIyQ9
X-Proofpoint-ORIG-GUID: upJ3djYcZxgHdoQisBColz9-kmPEIyQ9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 11 Feb 2022 14:42:54 +0800, chenxiang wrote:

> From: Xiang Chen <chenxiang66@hisilicon.com>
> 
> There are some cleanups related to scsi and libsas:
> - Use void for sas_discover_event() return code;
> - Remove duplicated setting for task->task_state_flags;
> - Remove unused parameter for function sas_ata_eh();
> - Remove unused member cmd_pool for structure scsi_host_template;
> 
> [...]

Applied to 5.18/scsi-queue, thanks!

[1/4] scsi: libsas: Use void for sas_discover_event() return code
      https://git.kernel.org/mkp/scsi/c/26d4a969dd05
[2/4] scsi: libsas: Remove duplicated setting for task->task_state_flags
      https://git.kernel.org/mkp/scsi/c/59803ccb657d
[3/4] scsi: libsas: Remove unused parameter for function sas_ata_eh()
      https://git.kernel.org/mkp/scsi/c/3a20e64281fd
[4/4] scsi: Remove unused member cmd_pool for structure scsi_host_template
      https://git.kernel.org/mkp/scsi/c/23406e4d1f1e

-- 
Martin K. Petersen	Oracle Linux Engineering
