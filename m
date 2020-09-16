Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6126B9CD
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 04:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIPCVp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 22:21:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgIPCVo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 22:21:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G2KStH098132;
        Wed, 16 Sep 2020 02:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=LeEyVylDk7XvwMhIFa/FRWetx3Qqu6EO+/ZH1dPO4Yc=;
 b=FlKASEpwsvsPxYjgwuruZgqrvW+qcfSciQgNW2DVZ0d1CSKc/LMA6QKU+6cJRf09npwU
 OFsocXwW4taYlhGriFP1spTOmy45Q0HF+XRBRoHxeMGCkb7Jp6pRGSiOAYm+uEPvjTg1
 nvHjemVjA4mP7DNyEy+FcNopAJcVRw6+i4GcuOiBsKQjzC0HlpNMmOBG1036rz6JfQRx
 xvKs4watGN+gK4C1t6lHaMijDEN55n1Um9xSG6HtxVoeWaAe1WU7VO4lt7WyNHFOYtMW
 BhslOMbwyFVA0urdt/TKa22pE4YEOYW4qFCMlSpUwU/E0nqD2dXdhNQtTIo6pXCRczUJ jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33gnrr0e0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 02:21:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G2Khsg052849;
        Wed, 16 Sep 2020 02:21:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33h890fe80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 02:21:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08G2LNq2012184;
        Wed, 16 Sep 2020 02:21:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 02:21:22 +0000
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Long Li <longli@microsoft.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH V7] scsi: core: only re-run queue in scsi_end_request()
 if device queue is busy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a6xqxy0c.fsf@ca-mkp.ca.oracle.com>
References: <20200910075056.36509-1-ming.lei@redhat.com>
Date:   Tue, 15 Sep 2020 22:21:20 -0400
In-Reply-To: <20200910075056.36509-1-ming.lei@redhat.com> (Ming Lei's message
        of "Thu, 10 Sep 2020 15:50:56 +0800")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=1 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=1
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160013
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Ming,

> Now the request queue is run in scsi_end_request() unconditionally if
> both target queue and host queue is ready. We should have re-run
> request queue only after this device queue becomes busy for restarting
> this LUN only.
>
> Recently Long Li reported that cost of run queue may be very heavy in
> case of high queue depth. So improve this situation by only running
> the request queue when this LUN is busy.

Applied to 5.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
