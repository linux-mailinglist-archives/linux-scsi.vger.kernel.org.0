Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A6516B0A7
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Feb 2020 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXTzL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Feb 2020 14:55:11 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38384 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgBXTzK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Feb 2020 14:55:10 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OJs4tM072338;
        Mon, 24 Feb 2020 19:55:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=S2kmkHy/arlrkqP/Ydgx2RtSDWIDK4e5/5ycMv9aAGo=;
 b=NdWTjNZNNBdQDwVHFSGcmy0g8Q4YZJHJJo6LwsjHW0JKpg5QAvzEMeFjXAUlq9bkNz3h
 1VAIvwLPSivp0N+5CA3FjsS7G+K3fvbJgzpgqRqmCU8WLDwjvJ2iJnJfOQf+cyF9nc2Q
 uNRreiU+dDmDPowDzpmTfA4g+WTxCJqtiTjqPlGPMbILhic1YXbA0OjuydXNXSoxi1K6
 WjXO0h08WL+O2tCznvi0aI6P7r76ldXlpqj55TJKDnauAueo2iJ5oK16VhvyBsVeM6Vh
 aL02j01/oXm5zA+K51n27bi4Sx5Yvx2YLDXKKDzCug2VJUHIockvYFQh34LJ9NYwjcW+ tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ybvr4ny3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 19:55:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OJpwQb190484;
        Mon, 24 Feb 2020 19:54:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2ybe1203p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Feb 2020 19:54:59 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01OJssFu024035;
        Mon, 24 Feb 2020 19:54:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Feb 2020 11:54:53 -0800
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart van Assche <bvanassche@acm.org>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCHv2 0/3] ch: fixup refcounting imbalance for SCSI devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200213153207.123357-1-hare@suse.de>
Date:   Mon, 24 Feb 2020 14:54:51 -0500
In-Reply-To: <20200213153207.123357-1-hare@suse.de> (Hannes Reinecke's message
        of "Thu, 13 Feb 2020 16:32:04 +0100")
Message-ID: <yq1pne3dalw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=779 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=852 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240144
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hannes,

> here's a set of fixes for a long-standing issue in the 'ch' driver
> where we would crash if one of the referenced devices was removed from
> underneath us.

Applied to 5.7/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
