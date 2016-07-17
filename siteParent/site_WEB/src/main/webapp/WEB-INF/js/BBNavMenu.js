BBNavMenu = function(activeSelector, maxItems, startingRow){
	this.activeSelector = activeSelector;
	this.maxItems = maxItems;
	this.activeRow = startingRow;
	if (this.activeRow==null){
		this.activeRow = 1;
	}
	
	this.moveUp = function(){
		if (this.activeSelector!=null){
			if (this.activeRow<=1){
				this.activeRow=this.maxItems;
			} else {
				this.activeRow--;
			}
			this.updateRow(this.activeRow);
		}
	};
	
	this.moveDown = function(){
		if (this.activeSelector!=null){
			if (this.activeRow>=this.maxItems){
				this.activeRow=1;
			} else {
				this.activeRow++;
			}
			this.updateRow(this.activeRow);
		}
	};
	
	this.updateRow = function(row){
		if (this.activeSelector!=null){
			this.activeRow = row;
			document.getElementById(this.activeSelector).style.top=((this.activeRow-1)*4)+'vmin';
		}
	};
	
	this.updateActiveSelector = function(selector, maxItems, startingRow){
		if (this.activeSelector!=null){
			document.getElementById(this.activeSelector).style.display='none';
		}
		this.activeSelector = selector;
		this.maxItems = maxItems;
		this.activeRow = startingRow;
		if (this.activeRow==null){
			this.activeRow = 1;
		}
		if (this.activeSelector!=null){
			this.updateRow(this.activeRow);
			document.getElementById(this.activeSelector).style.display='';
		}
	};
	
	this.getRow = function(){
		return this.activeRow;
	}
	
	this.getSelector = function(){
		return this.activeSelector;
	}
	

	this.updateRow(this.activeRow);
}