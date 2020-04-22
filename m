Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2460B1B4AE5
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2020 18:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDVQwu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Apr 2020 12:52:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53922 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDVQwt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Apr 2020 12:52:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MGmd5l016472;
        Wed, 22 Apr 2020 16:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=uN5oDoUrcSMXIH61koWBoMIDGKR2buXMUx19bspQ1oo=;
 b=MPWYytcJ+VM4418fwagvj05fFjlsdTb/u802H/MTeykMuLSyw94i2PeGCxgHvwcpZahk
 OJSwpUxeNqxOl7EMfXniOjCAQ9sNQr5j1QXdtO7noxNDwO6iVcj1s5xiXdrsAr0cfSLb
 0bZ1MOr82T23dUuJ8/vHaC3LtiII8hbg5WFtEjBnFID+WSdso9rKGK8+QpyAe6quEf2f
 XcqSSh0MOito4B1p2Uf5TQg6Z4628ixSIG/wlQ+YTim08Sgsi7i0l+HCtKM0VdY18RtW
 b3hDLCBmusHfm90zNNJ+mGkGfyv/FhlMLJdRgeolIFZJIHT4DqYKQvWuD07XtMXoHdRg Fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30fsgm42et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 16:52:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MGlWb9022322;
        Wed, 22 Apr 2020 16:50:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30gb9314qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 16:50:44 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03MGogxR021350;
        Wed, 22 Apr 2020 16:50:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 09:50:42 -0700
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 7/7] scsi_debug: implement zbc host-aware emulation
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200422104221.378203-1-damien.lemoal@wdc.com>
        <20200422104221.378203-8-damien.lemoal@wdc.com>
        <7a673425-195a-bd5f-bcf9-66e2c6cdb3fc@interlog.com>
Date:   Wed, 22 Apr 2020 12:50:40 -0400
In-Reply-To: <7a673425-195a-bd5f-bcf9-66e2c6cdb3fc@interlog.com> (Douglas
        Gilbert's message of "Wed, 22 Apr 2020 12:46:13 -0400")
Message-ID: <yq1eesfh3bz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=933 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220126
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Doug,

> To see a disk is ZBC host-aware it needs access to the Block Device
> Characteristics VPD page, but as far as I can see that is not loaded
> into sysfs at this time. Hannes?

That's coming in my sd fixes series later today. Made a ton of changes
in this area.

-- 
Martin K. Petersen	Oracle Linux Engineering
