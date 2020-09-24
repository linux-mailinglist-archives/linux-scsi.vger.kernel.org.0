Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915FE2777C4
	for <lists+linux-scsi@lfdr.de>; Thu, 24 Sep 2020 19:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgIXR1T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 24 Sep 2020 13:27:19 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50030 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727988AbgIXR1T (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 24 Sep 2020 13:27:19 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OHQ1YH013910
        for <linux-scsi@vger.kernel.org>; Thu, 24 Sep 2020 10:27:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=cRjkC8LDkfbw7LgIbbYGrH6jFqMN1aPgrEX8lqzPzV4=;
 b=Wt3tjWNrSnmFjESR9cf41uhTFjshHudRgmvpxm9RQYEMEIcz+vIYzVW5kePvYHJIkZkG
 gVltANfV262nryw9ZC3lfI6/BHI84ODaXeU4nKFAB/hHSJeos7Gm0fmiJKxEUQSkgxYb
 Fq1YNhA/WZp+zCg8o5YJKB+2nbXTSH69JOGBnGeEu/wzVdyQR1cmlruOG12xrPjyB5gE
 BlYE9PTl/177kSkCnr6iL6iGSB3JFr0SnzyQjES+xVkCH50od2/sjgoOVF4zdkEGaMWk
 boMweCy+vDYYPkejrkycpe5v8Wulkss6omw9I+MG8J/gkAWzzs/aUzYNJYtgxxWY1F7N rw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 33nfbq68sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 24 Sep 2020 10:27:18 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Sep
 2020 10:27:18 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Sep
 2020 10:27:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 10:27:16 -0700
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id ACDA03F7048;
        Thu, 24 Sep 2020 10:27:16 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 08OHRGLW000849;
        Thu, 24 Sep 2020 10:27:16 -0700
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Thu, 24 Sep 2020 10:27:16 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-scsi@vger.kernel.org>
Subject: Re: [EXT] [bug report] scsi: qla2xxx: Setup debugfs entries for
 remote ports
In-Reply-To: <20200924085945.GA1569340@mwanda>
Message-ID: <alpine.LRH.2.21.9999.2009241022060.28578@irv1user01.caveonetworks.com>
References: <20200924085945.GA1569340@mwanda>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_11:2020-09-24,2020-09-24 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 24 Sep 2020, 1:59am, Dan Carpenter wrote:

> ----------------------------------------------------------------------
> Hello Arun Easi,
> 
> The patch 1e98fb0f9208: "scsi: qla2xxx: Setup debugfs entries for
> remote ports" from Sep 3, 2020, leads to the following static checker
> warning:
> 
> 	drivers/scsi/qla2xxx/qla_dfs.c:119 qla2x00_dfs_create_rport()
> 	warn: 'fp->dfs_rport_dir' is an error pointer or valid
> 
> drivers/scsi/qla2xxx/qla_dfs.c
>    106  qla2x00_dfs_create_rport(scsi_qla_host_t *vha, struct fc_port *fp)
>    107  {
>    108          char wwn[32];
>    109  
>    110  #define QLA_CREATE_RPORT_FIELD_ATTR(_attr)                      \
>    111          debugfs_create_file(#_attr, 0400, fp->dfs_rport_dir,    \
>    112                  fp, &qla_dfs_rport_field_##_attr##_fops)
>    113  
>    114          if (!vha->dfs_rport_root || fp->dfs_rport_dir)
>    115                  return;
>    116  
>    117          sprintf(wwn, "pn-%016llx", wwn_to_u64(fp->port_name));
>    118          fp->dfs_rport_dir = debugfs_create_dir(wwn, vha->dfs_rport_root);
>    119          if (!fp->dfs_rport_dir)
> 
> Just delete this test.  Debugfs functions are not supposed to be checked
> in the normal case.

Thanks Dan for reporting. I will make the change and post a separate 
patch.

Regards,
-Arun

