Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B73662F3
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 02:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfGLAh2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 20:37:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52920 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGLAh2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 20:37:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0XtoU081802;
        Fri, 12 Jul 2019 00:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=iMJdg14sOKcN6igDsVxnD4yiCDEz74b9GkRCaijOxBk=;
 b=Kv+hiGs0N4N17zl1JvxiafYMnHcDLfFdJzbFv5GvQlbA+V3dqV/Lxp3InsR1YkDvPU1+
 eDhYegNgXIIODdVz8zJJ1KTrSnpAB8tb0IGMl8HSfJQ7vX3PWb/SYRKuJ0Pt9NV7BlxC
 s47O1mVMBQITL+qnF1GUL8UN3yQZtfNoN4jGzv+1AFVydSv0lKalhDyuutCmIcnnyI57
 6n70KPO81fLB4Z81YEPMz6sts2O+b1T87tVCtKIze17xGO8dgJGUjPdBCu43WCZH2bO9
 WlPNgKv+Wp9Znz/SWDe9AMIDbKAfn5mZ6D8Jg2wWiNhr9+889P3nr5T7IDcYq8MNLqna ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tjk2u2x4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:37:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C0XPbX137030;
        Fri, 12 Jul 2019 00:37:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2tmwgyfjgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 00:37:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C0bKq7003827;
        Fri, 12 Jul 2019 00:37:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 17:37:19 -0700
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     <linux-scsi@vger.kernel.org>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microchip.com>, <jinpu.wang@cloud.ionos.com>,
        <martin.petersen@oracle.com>
Subject: Re: [PATCH V2 1/3] pm80xx : Fixed kernel panic during error recovery for SATA drive.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190709100050.6947-1-deepak.ukey@microchip.com>
        <20190709100050.6947-2-deepak.ukey@microchip.com>
Date:   Thu, 11 Jul 2019 20:37:17 -0400
In-Reply-To: <20190709100050.6947-2-deepak.ukey@microchip.com> (Deepak Ukey's
        message of "Tue, 9 Jul 2019 15:30:48 +0530")
Message-ID: <yq1bly084w2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=824 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120005
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Deepak,

> Disabling the SATA drive interface cause kernel panic. When the drive
> Interface is disabled, device should be deregistered after aborting
> all pending IO's. Also changed the port recovery timeout to 10000 ms
> for PM8006 controller.

Applied to 5.3/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
