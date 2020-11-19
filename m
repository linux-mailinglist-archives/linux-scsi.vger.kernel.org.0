Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DF32B95AE
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Nov 2020 16:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgKSPEd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 10:04:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:45924 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgKSPEc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Nov 2020 10:04:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJEsLhu178597;
        Thu, 19 Nov 2020 15:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3iuJfllWNDFpqOP3OVs2BGzQRlYzNjiqptp4PKzPruQ=;
 b=DiaP0WjOqSq2NAlRahxAGjn4veMBSzfQFPzrijjpUV4Y0fYlYG4PaIk86y+mAvvk6CNh
 LpTBs6nzZVaqXeueHMNb/COo/L43wgNtyv5ukmziJYzHbVPa1V9719+7eAYXW4Zy8VMl
 oT709r3b/Rn+DBWqdP5qK1BgE7mZP6czBTpsnjup7JaxPf8FQVMLa62D67/w6g/uMJyV
 ygLNeF4rKyK/Eg1xhtyUzghLZCRisrzvQld76u5PtUcn6sVuqugXslAdaAYewjeKGwWD
 TEq1NCpMJFaZDdlu2mkHL0Cgz+SfIXPm8dqwogj6cFuyOaWZPiwKyz4AM7HKto47JR0x jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34t4rb5y65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 15:03:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJEtNIN138932;
        Thu, 19 Nov 2020 15:03:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34umd22n8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 15:03:47 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AJF3iaO013403;
        Thu, 19 Nov 2020 15:03:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 07:03:43 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     salyzyn@google.com, kernel-team@android.com,
        nguyenb@codeaurora.org, hongwus@codeaurora.org,
        saravanak@google.com, asutoshd@codeaurora.org,
        Can Guo <cang@codeaurora.org>, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] scsi: ufs: Make sure clk scaling happens only when hba is runtime ACTIVE
Date:   Thu, 19 Nov 2020 10:03:41 -0500
Message-Id: <160579821161.27938.15426150263135159232.b4-ty@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <1600758548-28576-1-git-send-email-cang@codeaurora.org>
References: <1600758548-28576-1-git-send-email-cang@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190113
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 22 Sep 2020 00:09:04 -0700, Can Guo wrote:

> If someone plays with the UFS clk scaling devfreq governor through sysfs,
> ufshcd_devfreq_scale may be called even when hba is not runtime ACTIVE,
> which can lead to unexpected error. We cannot just protect it by calling
> pm_runtime_get_sync, because that may cause racing problem since hba
> runtime suspend ops needs to suspend clk scaling. In order to fix it, call
> pm_runtime_get_noresume and check hba's runtime status, then only proceed
> if hba is runtime ACTIVE, otherwise just bail.
> 
> [...]

Applied to 5.10/scsi-fixes, thanks!

[1/1] scsi: ufs: Make sure clk scaling happens only when HBA is runtime ACTIVE
      https://git.kernel.org/mkp/scsi/c/73cc291c2702

-- 
Martin K. Petersen	Oracle Linux Engineering
