Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8622E285754
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Oct 2020 05:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgJGDuc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Oct 2020 23:50:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39822 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgJGDuZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Oct 2020 23:50:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0973k89K167332;
        Wed, 7 Oct 2020 03:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=pemFeEsxzt7MLAVrTDVefhye6T4Fi310NOL4bybYSmo=;
 b=QLM8ZuNICdoK8IfAooMDnr2/hXfVh0XnqGUD99QVLF6sITNhJpt31ZjqC2GfeKGqZHhO
 +cTXNyh7j9SNX9PtqTYeNuZW3DsN5VyVlCIGCiaK1I8d7kEBAVtom5pddWgM54fSe0iQ
 wV/FyQNZxkXFJPu4GBbLrwACw3XI30RGo0wUR+SwFB/WD24JYwA7MjxspkFhPoFQVfyf
 NKraF1oQqlv7R38U6cfzqks+5bEP2nqv/RYiDmLjFJpd+j6yr9Fa0ktUw67fyYAv/yeG
 pNf8K5y2SubYRqkwJk1hwAmcJbWwQ87LQcpQC6Wt/e2qgKSO5HIs0nsr/5qNOHnt2aZD gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxmydh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 03:50:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0973ioR2194563;
        Wed, 7 Oct 2020 03:48:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3410jy2s60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 03:48:23 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0973mKlD025081;
        Wed, 7 Oct 2020 03:48:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 20:48:20 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Roman Bolshakov <r.bolshakov@yadro.com>,
        target-devel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux@yadro.com
Subject: Re: [PATCH] scsi: target: core: Add CONTROL field for trace events
Date:   Tue,  6 Oct 2020 23:48:00 -0400
Message-Id: <160204240573.16940.10978624159806052406.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929125957.83069-1-r.bolshakov@yadro.com>
References: <20200929125957.83069-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070023
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 29 Sep 2020 15:59:57 +0300, Roman Bolshakov wrote:

> trace-cmd report doesn't show events from target subsystem because
> scsi_command_size() leaks through event format string:
> 
>   [target:target_sequencer_start] function scsi_command_size not defined
>   [target:target_cmd_complete] function scsi_command_size not defined
> 
> Addition of scsi_command_size() to plugin_scsi.c in trace-cmd doesn't
> help because an expression is used inside TP_printk(). trace-cmd event
> parser doesn't understand minus sign inside [ ]:
> 
> [...]

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: target: core: Add CONTROL field for trace events
      https://git.kernel.org/mkp/scsi/c/7010645ba725

-- 
Martin K. Petersen	Oracle Linux Engineering
