import React from 'react';
import PropTypes from 'prop-types';
import Fab from '@material-ui/core/Fab';
import AddIcon from '@material-ui/icons/Add';
import useStyles from './useStyles.js';

function NewTaskButton({ onClick }) {
  const styles = useStyles();

  return (
    <Fab className={styles.addButton} color="primary" aria-label="add" onClick={onClick}>
      <AddIcon />
    </Fab>
  );
}

NewTaskButton.propTypes = {
  onClick: PropTypes.func.isRequired,
};

export default NewTaskButton;
