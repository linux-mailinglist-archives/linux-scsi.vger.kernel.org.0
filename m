Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649CD27DEF7
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 05:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgI3D1y (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 23:27:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38378 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgI3D1y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 29 Sep 2020 23:27:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U3NdvV178121;
        Wed, 30 Sep 2020 03:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=BJV571ZTGLOfcG5LFV96Nn3eQoJN3InJUE31O/tNeRc=;
 b=wpSPV+HlnO63JVjlx0u8xlFY5dqq5KsbcYJdP1Phcds+FRJk8/ct715kZR5sYh1gKexi
 XHm+wPrWDp5Tl4hFa9ALSpLPjVqKJmegvV/F5ZQJ2tVXvy+oLZonr68bvJrUfQJuTdy6
 xc61ifkEJzdM7BdGPDCbh1qTauOQ5Cvl4WIGLY/1Y/cSQWkdpz67Bx6/zCVZ8PZ8gv1n
 gByv4gZ+7XWiu9iCsvppUkRdLrKk1/KokoC7hHrS0Cg18hPTJ16jx9sb/WRckXIq9AUN
 LMGAWFJqcJbhhWsLMv8s9GqbDt8wg8x1NnWUJlGTjunjHR7QwA3+5DY1Q/GFuHoN2ItP KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33swkkx9b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 03:27:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U3QWTF064919;
        Wed, 30 Sep 2020 03:27:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33tfhygg36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 03:27:52 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08U3Rorv003238;
        Wed, 30 Sep 2020 03:27:50 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 20:27:50 -0700
To:     Nilesh Javali <njavali@marvell.com>
Cc:     <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [PATCH v2 0/7] qla2xxx bug fixes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h7rggd1m.fsf@ca-mkp.ca.oracle.com>
References: <20200929102152.32278-1-njavali@marvell.com>
Date:   Tue, 29 Sep 2020 23:27:48 -0400
In-Reply-To: <20200929102152.32278-1-njavali@marvell.com> (Nilesh Javali's
        message of "Tue, 29 Sep 2020 03:21:45 -0700")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=973 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=986 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300023
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Nilesh,

> Please apply the qla2xxx bug fixes to the scsi tree at your earliest
> convenience.

> Added correct "Fixes:" and "Cc:" tags in commits

Applied to 5.10/scsi-staging, thanks!

Your Fixes: tags used 13-char SHAs instead of 12. I fixed them up.

-- 
Martin K. Petersen	Oracle Linux Engineering
